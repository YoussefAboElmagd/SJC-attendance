import 'package:dio/dio.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
// import 'package:labaiik_mo3tmer/Core/helpers/cach_helper.dart';
// import 'package:labaiik_mo3tmer/Core/helpers/shared_key.dart';
// import 'package:labaiik_mo3tmer/Core/helpers/shared_pref_helper.dart';
// import 'package:doc_doc2/Core/helpers/shared_key.dart';
// import 'package:doc_doc2/Core/helpers/shared_pref_helper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class DioFactory {
//   DioFactory._();

//   static Dio? dio;

//   static Dio getDio() {
//     Duration timeOut = const Duration(seconds: 30);

//     if (dio == null) {
//       dio = Dio();
//       dio!
//         ..options.connectTimeout = timeOut
//         ..options.receiveTimeout = timeOut;
//       addDioHeaders();
//       addDioLogger();
//       return dio!;
//     } else {
//       return dio!;
//     }
//   }

//   static void addDioHeaders() async {
//     dio?.options.headers = {
//       'Accept': 'application/json',
//       'Authorization':
//           'Bearer ${await SharedPrefHelper.getSecuredString(SharedKeys.userToken)}',
//     };
//   }

//   static void setTokenAfterLogin(String token) async {
//     dio?.options.headers = {
//       'Authorization': 'Bearer $token',
//     };
//   }

//   static void addDioLogger() {
//     dio?.interceptors.add(
//       PrettyDioLogger(
//         requestBody: true,
//         requestHeader: true,
//         responseHeader: true,
//       ),
//     );
//   }
// }

class DioFactory {
  DioFactory._();

  static Dio? dio;
  static Future<Dio> getDio() async {
    Duration timeOut = const Duration(
      seconds: 30,
    );
    if (dio == null) {
      dio = Dio();
      await addDioHeaders(); // Await here to ensure headers are set
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

      addDioLogger();
      return dio!;
    } else {
      return dio!;
    }
  }
  // static Future<Dio> getDio() async {
  //   Duration timeOut = const Duration(minutes: 1);
  //   if (dio == null) {
  //     dio = Dio();
  //     print("dio ${dio!.options}");

  //     dio!
  //       ..options.connectTimeout = timeOut
  //       ..options.receiveTimeout = timeOut;
  //     print("dio ${dio!.options}");

  //     addDioHeaders();
  //     addDioLogger();
  //     return dio!;
  //   } else {
  //     return dio!;
  //   }
  // }

  static Future<void> addDioHeaders() async {
    // print(await CachHelper.getSecuredString(key: SharedKeys.userToken));
    print(
        'userToken ${await CachHelper.getSecuredString(key: SharedKeys.userToken)}');
    dio?.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'access-token':
          '${await CachHelper.getSecuredString(key: SharedKeys.userToken)}',
    };
  }

  static void setTokenAfterLogin(String? token) async {
    // print(token);
    dio?.options.headers = {
      'access-token': "$token",
    };
  }

  static void addDioLogger() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
