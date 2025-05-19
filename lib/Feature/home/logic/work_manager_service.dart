// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:workmanager/workmanager.dart';
// import 'package:madarj/Core/helpers/cach_helper.dart';

// // 1. Background Task Handlers (Top-Level Functions)
// // =================================================

// @pragma('vm:entry-point')
// Future<bool> _handleBackgroundShiftCheck(FlutterLocalNotificationsPlugin notifications) async {
//   try {
//     final isCheckedIn = await CachHelper.getData(key: 'is_checked_in') ?? false;
//     if (!isCheckedIn) return true;

//     final startStr = await CachHelper.getData(key: 'checkin_start_time');
//     if (startStr == null) return true;

//     final duration = DateTime.now().difference(DateTime.parse(startStr)).inSeconds;
//     if (duration >= 120) { // 2 minutes for testing
//       await _sendBackgroundNotification(
//         notifications,
//         title: 'انتهت فترة الشيفت',
//         body: 'لقد انتهت فترة الشيفت الخاصة بك ولم تقم بتسجيل الخروج!',
//       );
      
//       final today = DateTime.now().toIso8601String().split('T').first;
//       final totalToday = (await CachHelper.getData(key: 'usage_$today') ?? 0) + duration;
//       await CachHelper.saveData(key: 'usage_$today', value: totalToday);
      
//       await CachHelper.saveData(key: 'is_checked_in', value: false);
//       await CachHelper.removeData(key: 'checkin_start_time');
//     }
//     return true;
//   } catch (e) {
//     return false;
//   }
// }

// @pragma('vm:entry-point')
// Future<bool> _handleDailyUsageCheck(FlutterLocalNotificationsPlugin notifications) async {
//   final now = DateTime.now();
//   final today = now.toIso8601String().split('T').first;
  
//   if (await CachHelper.getData(key: 'current_tracking_day') != today) {
//     await CachHelper.saveData(key: 'current_tracking_day', value: today);
//     await CachHelper.saveData(key: 'usage_$today', value: 0);
//   }
//   return true;
// }

// @pragma('vm:entry-point')
// Future<void> _sendBackgroundNotification(
//   FlutterLocalNotificationsPlugin notifications,
//   {required String title, required String body}
// ) async {
//   await notifications.show(
//     1,
//     title,
//     body,
//     const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'shift_channel',
//         'Shift Notifications',
//         importance: Importance.high,
//         priority: Priority.high,
//       ),
//     ),
//   );
// }

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     try {
//       await CachHelper.init();
//       final notifications = FlutterLocalNotificationsPlugin();
//       await notifications.initialize(
//         const InitializationSettings(
//           android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//         ),
//       );

//       switch (task) {
//         case "unfinishedShiftCheck":
//           return await _handleBackgroundShiftCheck(notifications);
//         case "dailyUsageCheck":
//           return await _handleDailyUsageCheck(notifications);
//         default:
//           return false;
//       }
//     } catch (e) {
//       return false;
//     }
//   });
// }

// // 2. Main WorkManagerService Class
// // ================================

// class WorkManagerService {
//   static final WorkManagerService _instance = WorkManagerService._internal();
//   factory WorkManagerService() => _instance;
//   WorkManagerService._internal();

//   Future<void> init() async {
//     await Workmanager().initialize(
//       callbackDispatcher,
//       isInDebugMode: true,
//     );
    
//     await Workmanager().registerPeriodicTask(
//       'daily_reset_task',
//       'dailyUsageCheck',
//       frequency: const Duration(hours: 6),
//       constraints: Constraints(networkType: NetworkType.connected),
//     );
//   }

//   Future<void> startShift() async {
//     final now = DateTime.now();
//     final today = now.toIso8601String().split('T').first;

//     if (await CachHelper.getData(key: 'current_tracking_day') != today) {
//       await CachHelper.saveData(key: 'current_tracking_day', value: today);
//       await CachHelper.saveData(key: 'usage_$today', value: 0);
//     }

//     await CachHelper.saveData(
//       key: 'checkin_start_time',
//       value: now.toIso8601String(),
//     );
//     await CachHelper.saveData(key: 'is_checked_in', value: true);

//     await Workmanager().registerOneOffTask(
//       "shift_check_${now.millisecondsSinceEpoch}",
//       "unfinishedShiftCheck",
//       initialDelay: const Duration(minutes: 2),
//       constraints: Constraints(networkType: NetworkType.connected),
//       existingWorkPolicy: ExistingWorkPolicy.replace,
//     );
//   }

//   Future<void> endShift() async {
//     await Workmanager().cancelByTag("shift_check_");
//     await CachHelper.saveData(key: 'is_checked_in', value: false);

//     final startStr = await CachHelper.getData(key: 'checkin_start_time');
//     if (startStr != null) {
//       final duration = DateTime.now().difference(DateTime.parse(startStr)).inSeconds;
//       final today = DateTime.now().toIso8601String().split('T').first;
//       final totalToday = (await CachHelper.getData(key: 'usage_$today') ?? 0) + duration;
//       await CachHelper.saveData(key: 'usage_$today', value: totalToday);
      
//       if (totalToday >= 120) {
//         await _sendNotification(
//           title: 'تجاوز الوقت المسموح',
//           body: 'لقد قضيت أكثر من دقيقتين في التطبيق اليوم!',
//         );
//       }
//     }
    
//     await CachHelper.removeData(key: 'checkin_start_time');
//   }

//   static Future<void> _sendNotification({
//     required String title,
//     required String body,
//   }) async {
//     final notifications = FlutterLocalNotificationsPlugin();
//     await notifications.show(
//       0,
//       title,
//       body,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'shift_channel',
//           'Shift Notifications',
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       ),
//     );
//   }
// }
/////////////////////////////

// import 'package:madarj/Core/helpers/cach_helper.dart';
// import 'package:madarj/Feature/home/logic/firebase_servies_local.dart';
// import 'package:workmanager/workmanager.dart';

// class WorkManagerService {
//   static final WorkManagerService _instance = WorkManagerService._internal();
//   factory WorkManagerService() => _instance;
//   WorkManagerService._internal();

//   // Initialize WorkManager and setup tasks
//   Future<void> init() async {
//     await Workmanager().initialize(
//       _callbackDispatcher,
//       isInDebugMode: true,
//     );

//     // Setup periodic task (optional)
//     await Workmanager().registerPeriodicTask(
//       'periodic_shift_check',
//       'periodicShiftCheck',
//       frequency: const Duration(minutes: 15),
//       constraints: Constraints(
//         networkType: NetworkType.connected,
//       ),
//     );
//   }

//   // Start tracking shift
//   // Future<void> startShiftTracking() async {
//   //   final now = DateTime.now();
//   //   final today = now.toIso8601String().split('T').first;

//   //   await CachHelper.saveData(
//   //       key: 'checkin_start_time', value: now.toIso8601String());

//   //   if (CachHelper.getData(key: 'current_tracking_day') != today) {
//   //     await CachHelper.saveData(key: 'current_tracking_day', value: today);
//   //     await CachHelper.saveData(key: 'usage_$today', value: 0);
//   //   }

//   //   await Workmanager().registerOneOffTask(
//   //     "unfinished_shift_check",
//   //     "unfinishedShiftCheck",
//   //     initialDelay: const Duration(minutes: 2),
//   //     constraints: Constraints(
//   //       networkType: NetworkType.connected,
//   //     ),
//   //     existingWorkPolicy: ExistingWorkPolicy.replace,
//   //   );
//   // }
//   Future<void> startShiftTracking() async {
//     final now = DateTime.now();
//     final today = now.toIso8601String().split('T').first;

//     await CachHelper.saveData(
//         key: 'checkin_start_time', value: now.toIso8601String());

//     if (CachHelper.getData(key: 'current_tracking_day') != today) {
//       await CachHelper.saveData(key: 'current_tracking_day', value: today);
//       await CachHelper.saveData(key: 'usage_$today', value: 0);
//     }

//     // إلغاء أي مهام سابقة أولاً
//     await Workmanager().cancelByTag("unfinished_shift_check");

//     // تسجيل المهمة الجديدة
//     await Workmanager().registerOneOffTask(
//       "unfinished_shift_check_${now.millisecondsSinceEpoch}", // إضافة timestamp لمنع التكرار
//       "unfinishedShiftCheck",
//       initialDelay: const Duration(minutes: 2),
//       constraints: Constraints(
//         networkType: NetworkType.connected,
//       ),
//       existingWorkPolicy: ExistingWorkPolicy.replace,
//     );
//   }

//   // End shift tracking

//   Future<void> endShiftTracking() async {
//     await Workmanager().cancelByTag("unfinished_shift_check");

//     final startStr = CachHelper.getData(key: 'checkin_start_time');
//     if (startStr == null) return;

//     final startTime = DateTime.parse(startStr);
//     final duration = DateTime.now().difference(startTime).inSeconds;

//     final today = DateTime.now().toIso8601String().split('T').first;
//     final totalToday =
//         (CachHelper.getData(key: 'usage_$today') ?? 0) + duration;

//     await CachHelper.saveData(key: 'usage_$today', value: totalToday);
//     await CachHelper.removeData(key: 'checkin_start_time');

//     if (totalToday >= 120) {
//       await _sendLimitNotification();
//     }
//   }

//   // Callback dispatcher for background tasks
//   // static Future<void> _callbackDispatcher() async {
//   //   Workmanager().executeTask((task, inputData) {
//   //     switch (task) {
//   //       case "unfinishedShiftCheck":
//   //         return _checkUnfinishedShift();
//   //       case "periodicShiftCheck":
//   //         return _checkDailyUsage();
//   //       default:
//   //         return Future.value(false);
//   //     }
//   //   });
//   // }
//   @pragma('vm:entry-point')
//   static Future<void> _callbackDispatcher() async {
//     Workmanager().executeTask((task, inputData) async {
//       try {
//         // تهيئة CachHelper إذا لزم الأمر
//         if (CachHelper.getData(key: 'is_initialized') == null) {
//           await CachHelper.init();
//         }

//         switch (task) {
//           case "unfinishedShiftCheck":
//             final isCheckedIn =
//                 CachHelper.getData(key: 'is_checked_in2') ?? false;
//             if (isCheckedIn) {
//               return await _checkUnfinishedShift();
//             }
//             return true;

//           case "periodicShiftCheck":
//             return await _checkDailyUsage();

//           default:
//             return Future.value(false);
//         }
//       } catch (e) {
//         return Future.value(false);
//       }
//     });
//   }

//   // Check for unfinished shift
//   // static Future<bool> _checkUnfinishedShift() async {
//   //   try {
//   //     final startStr = CachHelper.getData(key: 'checkin_start_time');
//   //     if (startStr == null) return true;

//   //     final duration =
//   //         DateTime.now().difference(DateTime.parse(startStr)).inSeconds;
//   //     if (duration >= 120) {
//   //       await _sendUnfinishedShiftNotification();
//   //       await CachHelper.removeData(key: 'checkin_start_time');
//   //     }
//   //     print("Current time: ${DateTime.now()}");
//   //     // print("Shift started at: $startTime");
//   //     print("Duration calculated: $duration seconds");
//   //     return true;
//   //   } catch (e) {
//   //     return false;
//   //   }
//   // }
//   @pragma('vm:entry-point')
//   static Future<bool> _checkUnfinishedShift() async {
//     try {
//       final startStr = CachHelper.getData(key: 'checkin_start_time');
//       if (startStr == null) {
//         print("No active shift found");
//         return true;
//       }

//       final startTime = DateTime.parse(startStr);
//       final duration = DateTime.now().difference(startTime).inSeconds;
//       print("Shift duration: $duration seconds");

//       if (duration >= 120) {
//         print("Sending unfinished shift notification");
//         await _sendUnfinishedShiftNotification();

//         // إضافة الوقت المحتسب إلى اليوم الحالي
//         final today = DateTime.now().toIso8601String().split("T").first;
//         final totalToday =
//             (CachHelper.getData(key: 'usage_$today') ?? 0) + duration;
//         await CachHelper.saveData(key: 'usage_$today', value: totalToday);

//         // لا تحذف checkin_start_time هنا إذا أردت الاستمرار في التتبع
//       }
//       return true;
//     } catch (e) {
//       print("Error in _checkUnfinishedShift: $e");
//       return false;
//     }
//   }

//   // Check daily usage
//   @pragma('vm:entry-point')
//   static Future<bool> _checkDailyUsage() async {
//     final now = DateTime.now();
//     final today = now.toIso8601String().split("T").first;

//     if (CachHelper.getData(key: 'current_tracking_day') != today) {
//       await CachHelper.saveData(key: 'current_tracking_day', value: today);
//       await CachHelper.saveData(key: 'usage_$today', value: 0);
//     }

//     final totalToday = CachHelper.getData(key: 'usage_$today') ?? 0;
//     if (totalToday >= 120) {
//       await _sendLimitNotification();
//     }
//     return true;
//   }

//   // Notification methods
//   static Future<void> _sendLimitNotification() async {
//     await LocalNotificationService.showBasicNotification(
//       title: 'تجاوز الوقت المسموح',
//       body: 'لقد قضيت أكثر من دقيقتين في التطبيق اليوم!',
//     );
//   }

//   static Future<void> _sendUnfinishedShiftNotification() async {
//     await LocalNotificationService.showBasicNotification(
//       title: 'انتهت فترة الشيفت',
//       body: 'لقد انتهت فترة الشيفت الخاصة بك ولم تقم بتسجيل الخروج!',
//     );
//   }
// }

// // import 'package:madarj/Core/helpers/cach_helper.dart';
// // import 'package:madarj/Feature/home/logic/firebase_servies_local.dart';
// // import 'package:workmanager/workmanager.dart';
// // // steps
// // //1.init work manager
// // //2.excute our task.
// // //3.register our task in work manager

// // class WorkManagerService {
// //   void registerMyTask() async {
// //     //register my task
// //     await Workmanager().registerPeriodicTask(
// //       'id1',
// //       'show simple notification',
// //       frequency: const Duration(minutes: 15),
// //     );
// //   }

// //   //init work manager service
// //   Future<void> init() async {
// //     await Workmanager()
// //         .initialize(checkForUnfinishedShift, isInDebugMode: true);
// //     registerMyTask();
// //   }

// //   Future<void> startCheckInTracking() async {
// //     final now = DateTime.now();
// //     final today = now.toIso8601String().split('T').first;

// //     // Save check-in time
// //     await CachHelper.saveData(
// //         key: 'checkin_start_time', value: now.toIso8601String());

// //     // Initialize daily tracking if not exists
// //     if (CachHelper.getData(key: 'current_tracking_day') != today) {
// //       await CachHelper.saveData(key: 'current_tracking_day', value: today);
// //       await CachHelper.saveData(key: 'usage_$today', value: 0);
// //     }

// //     // Schedule a check for 2 minutes later (TEST MODE)
// //     await Workmanager().registerOneOffTask(
// //       "check_unfinished_shift",
// //       "checkUnfinishedShiftTask",
// //       initialDelay: const Duration(minutes: 2),
// //     );
// //   }

// //   Future<void> stopCheckOutTracking() async {
// //     // Cancel any pending notifications for unfinished shifts
// //     await Workmanager().cancelByTag("check_unfinished_shift");

// //     final startStr = CachHelper.getData(key: 'checkin_start_time');
// //     if (startStr == null) return;

// //     final startTime = DateTime.parse(startStr);
// //     final now = DateTime.now();
// //     final duration = now.difference(startTime).inSeconds;

// //     final today = now.toIso8601String().split('T').first;
// //     final key = 'usage_$today';
// //     final totalSoFar = CachHelper.getData(key: key) ?? 0;

// //     final totalToday = totalSoFar + duration;
// //     await CachHelper.saveData(key: key, value: totalToday);
// //     await CachHelper.removeData(key: 'checkin_start_time');

// //     // Check if total seconds exceed 120 (2 minutes for testing)
// //     if (totalToday >= 120) {
// //       await sendLimitNotification();
// //     }
// //   }
// // }
// // void callbackDispatcher() {
// //   Workmanager().executeTask((task, inputData) async {
// //     try {
// //       // Ensure CachHelper is initialized
// //       if (CachHelper.getData(key: 'is_initialized') == null) {
// //         await CachHelper.init();
// //       }

// //       // Handle different task types
// //       switch (task) {
// //         case "check_unfinished_shift":
// //           print("start checkForUnfinishedShift");
// //           await checkForUnfinishedShift();
// //           break;

// //         case "check_usage_once":
// //           final now = DateTime.now();
// //           final today = now.toIso8601String().split("T").first;
// //           print(now);
// //           print(today);

// //           final savedDay = CachHelper.getData(key: 'current_tracking_day');
// //           if (savedDay != today) {
// //             await CachHelper.saveData(
// //               key: 'current_tracking_day',
// //               value: today,
// //             );
// //             await CachHelper.saveData(key: 'usage_$today', value: 0);
// //             await CachHelper.removeData(key: 'checkin_start_time');
// //           }

// //           final totalToday = CachHelper.getData(key: 'usage_$today') ?? 0;
// //           if (totalToday >= 120) {
// //             await LocalNotificationService.showBasicNotification(
// //               title: 'Time Limit Exceeded',
// //               body: 'You have exceeded the allowed time for today',
// //             );
// //           }
// //           break;
// //       }

// //       return Future.value(true);
// //     } catch (e) {
// //       return Future.value(false);
// //     }
// //   });
// // }

// // Future<void> sendLimitNotification() async {
// //   await LocalNotificationService.showBasicNotification(
// //     title: 'تجاوز الوقت المسموح',
// //     body: 'لقد قضيت أكثر من دقيقتين في التطبيق اليوم!',
// //   );
// // }

// // @pragma('vm-entry-point')
// // Future<void> checkForUnfinishedShift() async {
// //   try {
// //     final startStr = CachHelper.getData(key: 'checkin_start_time');
// //     if (startStr == null) {
// //       print("no activiy");
// //       return;
// //     }
// //     final startTime = DateTime.parse(startStr);
// //     final duration = DateTime.now().difference(startTime).inSeconds;

// //     print(startTime);
// //     print(duration);
// //     print(duration >= 120);
// //     if (duration >= 120) {
// //       // 2 minutes
// //       await sendUnfinishedShiftNotification();
// //     }
// //   } catch (e) {
// //     // Handle error
// //   }
// // }

// // Future<void> sendUnfinishedShiftNotification() async {
// //   await LocalNotificationService.showBasicNotification(
// //     title: 'انتهت فترة الشيفت',
// //     body: 'لقد انتهت فترة الشيفت الخاصة بك ولم تقم بتسجيل الخروج!',
// //   );
// // }
