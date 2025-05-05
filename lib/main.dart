// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/bloc_observer/bloc_observer.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/madarj_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Pause rendering
  RendererBinding.instance.deferFirstFrame();

  await CachHelper.init();
  Bloc.observer = MyBlocObserver();
  await setGetIt();
  await ScreenUtil.ensureScreenSize();
  await checkUserLogged();
  // Resume rendering
  RendererBinding.instance.allowFirstFrame();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(
    const MadarjApp(),
  );
}
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

checkUserLogged() async {
  bool? isLogged = await CachHelper.getData(
    key: SharedKeys.isLogged,
  );
  String? userToken = await CachHelper.getSecuredString(
    key: SharedKeys.userToken,
  );
  if (isLogged == true && userToken != null) {
    AppConstants.isLogged = true;
  } else {
    AppConstants.isLogged = false;
  }
  // print("isLogged $isLogged");
  // if (isLogged == null || !isLogged || userToken == null) {
  //   print("USer don't logged");
  //   print(isLogged);
  //   print(userToken);

  //   AppConstants.isLogged = false;
  // } else {
  //   print(isLogged);
  //   print(userToken);
  //   print("USer  logged olay");
  //   AppConstants.isLogged = true;
  // }
}
