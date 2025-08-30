import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/home/logic/firebase_servies_local.dart';
import 'package:madarj/Feature/home/logic/push_firebase_notification.dart';
import 'package:madarj/firebase_options.dart';
import 'package:madarj/madarj_app.dart';
import 'package:madarj/Core/bloc_observer/bloc_observer.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await ScreenUtil.ensureScreenSize();
  await setGetIt();

  // Initialize Cache, Bloc observer, DI, ScreenUtil as before
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  LocalNotificationService.init();
  PushNotificationsService.init();
  await checkUserLogged();
  runApp(const MadarjApp());
}

Future<void> checkUserLogged() async {
  bool? isLogged = await CachHelper.getData(key: SharedKeys.isLogged);
  String? userToken = await CachHelper.getSecuredString(
    key: SharedKeys.userToken,
  );
  if (isLogged == true && userToken != null) {
    AppConstants.isLogged = true;
  } else {
    AppConstants.isLogged = false;
  }
}

  // Future.wait([
  //   LocalNotificationService.init(),
  //   // workManager.init(),
  // ]);
  // await LocalNotificationService.init();
  // await workManager.init();

  // Initialize notifications and background task
  // await initializeNotifications();

  // Workmanager().initialize(callbackDispatcher,isInDebugMode: true);

  // Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  // Workmanager().registerPeriodicTask(
  //   "check_usage_task",
  //   "checkUsageTask",
  //   frequency: const Duration(minutes: 15),
  // );
  // await Workmanager().registerOneOffTask(
  //   "check_usage_once",
  //   "checkUsageOnceTask",
  //   initialDelay: const Duration(minutes: 2),
  // );
// await Workmanager().registerOneOffTask(
//   "check_usage_once",
//   "checkUsageOnceTask",
//   initialDelay: const Duration(minutes: 2),
// );

  // Initialize Workmanager with exact alarm permission
  // await Workmanager().initialize(
  //   callbackDispatcher,
  //   isInDebugMode: true,
  // );
  // if (Platform.isAndroid) {
  //   await Workmanager().registerOneOffTask(
  //     "background_check",
  //     "check_unfinished_shift",
  //     initialDelay: Duration(minutes: 2),
  //     constraints: Constraints(
  //       networkType: NetworkType.connected,
  //     ),
  //     existingWorkPolicy: ExistingWorkPolicy.replace,
  //   );
  // }

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {

//     if (task == "check_unfinished_shift") {
//       final cubit = getIt<HomeCubit>();
//       await cubit.checkForUnfinishedShift();
//     }

//     // Existing daily check logic
//     final now = DateTime.now();
//     final today = now.toIso8601String().split("T").first;

//     final savedDay = CachHelper.getData(key: 'current_tracking_day');
//     if (savedDay != today) {
//       CachHelper.saveData(key: 'current_tracking_day', value: today);
//       CachHelper.saveData(key: 'usage_$today', value: 0);
//       CachHelper.removeData(key: 'checkin_start_time');
//     }

//     final totalToday = CachHelper.getData(key: 'usage_$today') ?? 0;
//     if (totalToday >= 120) {
//       await LocalNotificationService.showBasicNotification(
//         title: 'تجاوزت الوقت المحدد',
//         body: 'لقد قضيت أكثر من الوقت المسموح به اليوم.',
//       );
//     }

//     return Future.value(true);
//   });
// }


// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     final now = DateTime.now();
//     final today = now.toIso8601String().split("T").first;

//     final savedDay = CachHelper.getData(key: 'current_tracking_day');
//     if (savedDay != today) {
//       CachHelper.saveData(key: 'current_tracking_day', value: today);
//       CachHelper.saveData(key: 'usage_$today', value: 0);
//       CachHelper.removeData(key: 'checkin_start_time');
//     }

//     final totalToday = CachHelper.getData(key: 'usage_$today') ?? 0;

//     if (totalToday >= 120) {
//       await LocalNotificationService.showBasicNotification(
//         title: 'تجاوزت الوقت المحدد',
//         body: 'لقد قضيت أكثر من الوقت المسموح به اليوم.',
//       );
//     }

//     return Future.value(true);
//   });
// }

// Future<void> initializeNotifications() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   const InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);

//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// }

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     // final prefs = await CachHelper
//     //     .getSharedPreferencesInstance(); // تأكد من طريقة الوصول لـ SharedPreferences في كودك
//     final now = DateTime.now();
//     final today = now.toIso8601String().split("T").first;

//     final savedDay = CachHelper.getData(key: 'current_tracking_day');
//     if (savedDay != today) {
//       CachHelper.saveData(key: 'current_tracking_day', value: today);
//       CachHelper.saveData(key: 'usage_$today', value: 0);
//       CachHelper.removeData(key: 'checkin_start_time');
//     }

//     final totalToday = CachHelper.getData(key: 'usage_$today') ?? 0;

//     // للاختبار: 2 دقيقة = 120 ثانية
//     if (totalToday >= 120) {
//       await sendLimitNotification();
//     }

//     return Future.value(true);
//   });
// }

// Future<void> sendLimitNotification() async {
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//     'usage_channel',
//     'Usage Notification',
//     importance: Importance.max,
//     priority: Priority.high,
//   );

//   const NotificationDetails platformDetails =
//       NotificationDetails(android: androidDetails);

//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'تجاوزت الوقت المحدد',
//     'لقد قضيت أكثر من الوقت المسموح به اليوم.',
//     platformDetails,
//   );
// }


// // import 'package:device_preview/device_preview.dart';
// // import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Core/bloc_observer/bloc_observer.dart';
// import 'package:madarj/Core/di/dependency_injection.dart';
// import 'package:madarj/Core/helpers/cach_helper.dart';
// import 'package:madarj/Core/helpers/constants.dart';
// import 'package:madarj/Core/helpers/shared_key.dart';
// import 'package:madarj/madarj_app.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Pause rendering
//   RendererBinding.instance.deferFirstFrame();

//   await CachHelper.init();
//   Bloc.observer = MyBlocObserver();
//   await setGetIt();
//   await ScreenUtil.ensureScreenSize();
//   await checkUserLogged();
//   // Resume rendering
//   RendererBinding.instance.allowFirstFrame();

//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//     ),
//   );
//   runApp(
//     const MadarjApp(),
//   );
// }


// checkUserLogged() async {
//   bool? isLogged = await CachHelper.getData(
//     key: SharedKeys.isLogged,
//   );
//   String? userToken = await CachHelper.getSecuredString(
//     key: SharedKeys.userToken,
//   );
//   if (isLogged == true && userToken != null) {
//     AppConstants.isLogged = true;
//   } else {
//     AppConstants.isLogged = false;
//   }

// }

// import 'package:device_preview/device_preview.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Device Preview in debug mode only
//   final isInDebugMode = true; // Change this based on your environment

//   // Pause rendering
//   RendererBinding.instance.deferFirstFrame();

//   await CachHelper.init();
//   Bloc.observer = MyBlocObserver();
//   await setGetIt();
//   await ScreenUtil.ensureScreenSize();
//   await checkUserLogged();

//   // Resume rendering
//   RendererBinding.instance.allowFirstFrame();

//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//     ),
//   );

//   runApp(
//     isInDebugMode
//         ? DevicePreview(
//             enabled: true,
//             tools: const [
//               ...DevicePreview.defaultTools,
//               // Customize your device preview tools here
//             ],
//             builder: (context) => const MadarjApp(), // Your app widget
//           )
//         : const MadarjApp(), // Production version without DevicePreview
//   );
// }
