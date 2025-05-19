import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:madarj/Feature/home/logic/firebase_servies_local.dart';
// import 'package:ka3ba/Core/helpers/cach_helper.dart';
// import 'package:ka3ba/Core/helpers/constants.dart';
// import 'package:ka3ba/Features/notifications/logic/firebase_servies_local.dart';
// import 'package:push_notifications/services/local_notifications_service.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      print(value);
      // AppConstants.fcmToken = value;
      // CachHelper.saveData(key: "fcmtoken", value: value);
      sendTokenToServer(value!);
    });
    messaging.onTokenRefresh.listen((value) {
      print(value);
      sendTokenToServer(value);
    });
    FirebaseMessaging.onBackgroundMessage(handlebackgroundMessage);
    handleForegroundMessage();
    messaging.subscribeToTopic('customer').then((val) {
      log('customer');
    });

    // messaging.unsubscribeFromTopic('all');
  }

  static Future<void> handlebackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? 'null');
  }

  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // show local notification
        LocalNotificationService.showBasicNotification(
          message,
        );
      },
    );
  }

  static void sendTokenToServer(String token) {
    // option 1 => API
    // option 2 => Firebase
  }
}
