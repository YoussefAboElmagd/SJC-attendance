import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future init() async {
    // Create notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id',
      'channel_name',
      description: 'Channel for important notifications',
      importance: Importance.max,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Request permissions for iOS
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        // on: onDidReceiveLocalNotification,
      ),
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  // iOS callback for older versions
  static void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    // Handle the notification tap for iOS < 10
  }

  static void showBasicNotification(
    RemoteMessage message, {
    bool isBackgroundMessage = false,
  }) async {
    print("start");

    AndroidNotificationDetails android = const AndroidNotificationDetails(
      'channel_id', // Must match the channel created above
      'channel_name',
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
    );

    DarwinNotificationDetails ios = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
    );

    print("start2");

    NotificationDetails details = NotificationDetails(
      android: android,
      iOS: ios,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000), // Unique ID
      message.notification?.title ?? "Notification",
      message.notification?.body ?? "You have a new message",
      details,
    );

    print("start3");
  }

  static void showTestNotification() async {
    AndroidNotificationDetails android = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    DarwinNotificationDetails ios = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
    );

    NotificationDetails details = NotificationDetails(
      android: android,
      iOS: ios,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      "Test Notification",
      "This is a test notification",
      details,
    );
  }
}

// import 'dart:async';
// // import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:http/http.dart' as http;

// class LocalNotificationService {
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static StreamController<NotificationResponse> streamController =
//       StreamController();
//   static onTap(NotificationResponse notificationResponse) {
//     // log(notificationResponse.id!.toString());
//     // log(notificationResponse.payload!.toString());
//     streamController.add(notificationResponse);
//     // Navigator.push(context, route);
//   }

//   static Future init() async {
//     InitializationSettings settings = const InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings(),
//     );
//     flutterLocalNotificationsPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: onTap,
//       onDidReceiveBackgroundNotificationResponse: onTap,
//     );
//   }
//   // static Future init() async {
//   //   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   //     'channel_id', // Must match with the one used in notification details
//   //     'channel_name',
//   //     description: 'Channel for important notifications',
//   //     importance: Importance.max, // Set to MAX
//   //     playSound: true,
//   //   );

//   //   await flutterLocalNotificationsPlugin
//   //       .resolvePlatformSpecificImplementation<
//   //           AndroidFlutterLocalNotificationsPlugin>()
//   //       ?.createNotificationChannel(channel);

//   //   InitializationSettings settings = const InitializationSettings(
//   //     android: AndroidInitializationSettings('@mipmap/launcher_icon'),
//   //     iOS: DarwinInitializationSettings(),
//   //   );

//   //   flutterLocalNotificationsPlugin.initialize(
//   //     settings,
//   //     onDidReceiveNotificationResponse: onTap,
//   //     onDidReceiveBackgroundNotificationResponse: onTap,
//   //   );
//   // }

//   //basic Notification
//   static void showBasicNotification(
//     RemoteMessage message, {
//     bool isBackgroundMessage = false,
//   }) async {
//     print("start");
//     AndroidNotificationDetails android = const AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       priority: Priority.high,
//       importance: Importance.max,
//       playSound: true,
//     );
//     DarwinNotificationDetails ios = const DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//     print("start2");

//     NotificationDetails details = NotificationDetails(
//       android: android,
//       iOS: ios,
//     );
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       message.notification?.title,
//       message.notification?.body,
//       details,
//     );
//     print("start3");
//   }

//   static void showTestNotification() async {
//     AndroidNotificationDetails android = const AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//     );
//     DarwinNotificationDetails ios = const DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     NotificationDetails details = NotificationDetails(
//       android: android,
//       iOS: ios,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       "Test Notification",
//       "This is a test notification",
//       details,
//     );
//   }
// }


// // import 'dart:async';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // class LocalNotificationService {
// //   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();
// //   static StreamController<NotificationResponse> streamController =
// //       StreamController<NotificationResponse>.broadcast();

// //   static void onTap(NotificationResponse notificationResponse) {
// //     streamController.add(notificationResponse);
// //   }

// //   static Future<void> init() async {
    
// //     InitializationSettings settings = const InitializationSettings(
// //       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
// //       iOS: DarwinInitializationSettings(),
// //     );

// //     await flutterLocalNotificationsPlugin.initialize(
// //       settings,
// //       onDidReceiveNotificationResponse: onTap,
// //       onDidReceiveBackgroundNotificationResponse: onTap,
// //     );
// //   }

// //   // Notification with title and body parameters instead of RemoteMessage
// //   static Future<void> showBasicNotification({
// //     required String title,
// //     required String body,
// //   }) async {
// //     AndroidNotificationDetails android = const AndroidNotificationDetails(
// //       'channel_id',
// //       'channel_name',
// //       priority: Priority.high,
// //       importance: Importance.max,
// //       playSound: true,
// //     );
// //     DarwinNotificationDetails ios = const DarwinNotificationDetails(
// //       presentAlert: true,
// //       presentBadge: true,
// //       presentSound: true,
// //       // presentBanner: true,
// //       // presentList: true,
// //     );

// //     NotificationDetails details = NotificationDetails(
// //       android: android,
// //       iOS: ios,
// //     );

// //     await flutterLocalNotificationsPlugin.show(
// //       0,
// //       title,
// //       body,
// //       details,
// //     );
// //   }

// //   static Future<void> showTestNotification() async {
// //     AndroidNotificationDetails android = const AndroidNotificationDetails(
// //       'channel_id',
// //       'channel_name',
// //       importance: Importance.max,
// //       priority: Priority.high,
// //       playSound: true,
// //     );

// //     NotificationDetails details = NotificationDetails(
// //       android: android,
// //     );

// //     await flutterLocalNotificationsPlugin.show(
// //       0,
// //       "Test Notification",
// //       "This is a test notification",
// //       details,
// //     );
// //   } 
// // }
