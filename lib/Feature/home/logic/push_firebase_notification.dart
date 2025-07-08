import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Feature/home/logic/firebase_servies_local.dart';

@pragma('vm:entry-point')
class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  @pragma('vm:entry-point')
  static Future init() async {
    // Request permission first
    await messaging.requestPermission(alert: true, badge: true, sound: true);

    // Handle messages in all states
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    handleForegroundMessage();
    handleBackgroundMessagesWhenAppIsTerminated();

    try {
      // For iOS, wait for APNS token before proceeding
      if (Platform.isIOS) {
        String? apnsToken;
        // Retry up to 3 times with a delay
        for (int i = 0; i < 3 && apnsToken == null; i++) {
          apnsToken = await messaging.getAPNSToken();
          if (apnsToken == null) {
            await Future.delayed(const Duration(seconds: 1));
          }
        }
        if (apnsToken == null) {
          log('Warning: APNS token still not available after retries');
        }
      }

      // Get FCM token after APNS token is available (for iOS)
      final token = await messaging.getToken();
      if (token != null) {
        log('FCM Token: $token');
        AppConstants.fcmToken = token;
        await CachHelper.saveData(key: SharedKeys.fcmToken, value: token);

        // Only subscribe to topic after we have a valid token
        await messaging.subscribeToTopic('shift');
        log('Subscribed to shift topic');
      }
    } catch (e) {
      log('Error in FCM initialization: $e');
    }

    messaging.onTokenRefresh.listen((value) {
      log('FCM token refreshed: $value');
      AppConstants.fcmToken = value;
      CachHelper.saveData(key: SharedKeys.fcmToken, value: value);
    });
  }

  // Background handler (also used for terminated app)
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();

    // Show notification even if it's a location check message
    // LocalNotificationService.showBasicNotification(message);

    if (message.notification!.title == "verify location" ||
        message.notification!.body == "verify location" ||
        message.data["check"] == "location") {
      try {
        final position = await _tryGetLocation();
        if (position != null) {
          await _sendLocationToServer(position);
        }
      } catch (e) {
        log('Error in background location handler: $e');
      }
    }
    LocalNotificationService.showBasicNotification(message);
    log("Handling a background message: ${message.messageId}");
  }

  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log("Handling a foreground message: ${message.messageId}");

      // Check if it's a location verification notification
      if (message.notification?.title == "verify location" ||
          message.notification?.body == "verify location" ||
          message.data["check"] == "location") {
        try {
          final position = await _tryGetLocation();
          if (position != null) {
            await _sendLocationToServer(position);
          }
        } catch (e) {
          log('Error in foreground location handler: $e');
        }
      }

      // Pass isBackgroundMessage=false to prevent showing notification in foreground
      LocalNotificationService.showBasicNotification(
        message,
        isBackgroundMessage: false,
      );
    });
  }

  @pragma('vm:entry-point')
  // Handle when app is terminated
  static void handleBackgroundMessagesWhenAppIsTerminated() {
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        log("Handling a terminated app message: ${message.messageId}");

        // Show notification
        LocalNotificationService.showBasicNotification(message);

        if (message.notification!.title == "verify location" ||
            message.notification!.body == "verify location" ||
            message.data["check"] == "location") {
          log(
            "Location check received in terminated state - will process when app opens",
          );
        }
      }
    });
  }

  @pragma('vm:entry-point')
  // Helper method to try getting location
  static Future<Position?> _tryGetLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      log('Error getting location: $e');
      return null;
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _sendLocationToServer(Position position) async {
    try {
      final dio = await DioFactory.getDio();

      Map<String, double> body = {
        "latitude": position.latitude,
        "longitude": position.longitude,
      };
      await dio.post(
        "${ApiConstants.prodBaseDomain}notifications/verify-location",
        data: jsonEncode(body),
      );

      log('Location sent successfully');
    } catch (e) {
      log('Error sending location: $e');
      throw Exception('Error sending location: $e');
    }
  }
}
