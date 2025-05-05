// // import 'package:shared_preferences/shared_preferences.dart';

// // class CachHelper {
// //   static late SharedPreferences sharedPreferences;

// //   static init() async {
// //     sharedPreferences = await SharedPreferences.getInstance();
// //   }

// //   static Future<bool> saveData({
// //     required dynamic value,
// //     required String key,
// //   }) async {
// //     if (value is String) {
// //       return await sharedPreferences.setString(key, value);
// //     }
// //     if (value is int) {
// //       return await sharedPreferences.setInt(key, value);
// //     }
// //     if (value is bool) {
// //       return await sharedPreferences.setBool(key, value);
// //     }
// //     return await sharedPreferences.setDouble(key, value);
// //   }

// //   static dynamic getData({
// //     required String key,
// //   }) {
// //     return sharedPreferences.get(key);
// //   }

// //   static dynamic removeData({
// //     required String key,
// //   }) {
// //     return sharedPreferences.remove(key);
// //   }
// // }
// import 'package:shared_preferences/shared_preferences.dart';

// class CachHelper {
//   static late SharedPreferences sharedPreferences;

//   static init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }

//   static Future<bool> saveData({
//     required dynamic value,
//     required String key,
//   }) async {
//     bool result;
//     if (value is String) {
//       result = await sharedPreferences.setString(key, value);
//     } else if (value is int) {
//       result = await sharedPreferences.setInt(key, value);
//     } else if (value is bool) {
//       result = await sharedPreferences.setBool(key, value);
//     } else if (value is double) {
//       result = await sharedPreferences.setDouble(key, value);
//     } else {
//       throw Exception("Unsupported data type");
//     }

//     print('Data set: Key = $key, Value = $value');
//     return result;
//   }

//   static dynamic getData({
//     required String key,
//   }) {
//     final value = sharedPreferences.get(key);
//     print('Data retrieved: Key = $key, Value = $value');
//     return value;
//   }

//   static Future<bool> removeData({
//     required String key,
//   }) async {
//     final result = await sharedPreferences.remove(key);
//     print('Data removed: Key = $key');
//     return result;
//   }
// }
// import 'package:shared_preferences/shared_preferences.dart';

// class CachHelper {
//   static late SharedPreferences sharedPreferences;

//   static init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }

//   static Future<bool> saveData({
//     required dynamic value,
//     required String key,
//   }) async {
//     if (value is String) {
//       return await sharedPreferences.setString(key, value);
//     }
//     if (value is int) {
//       return await sharedPreferences.setInt(key, value);
//     }
//     if (value is bool) {
//       return await sharedPreferences.setBool(key, value);
//     }
//     return await sharedPreferences.setDouble(key, value);
//   }

//   static dynamic getData({
//     required String key,
//   }) {
//     return sharedPreferences.get(key);
//   }

//   static dynamic removeData({
//     required String key,
//   }) {
//     return sharedPreferences.remove(key);
//   }
// }
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:labaiik_mo3tmer/Features/registration/login/data/model/get_me_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required dynamic value,
    required String key,
  }) async {
    bool result;
    if (value is String) {
      result = await sharedPreferences.setString(key, value);
    } else if (value is int) {
      result = await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      result = await sharedPreferences.setBool(key, value);
    } else if (value is double) {
      result = await sharedPreferences.setDouble(key, value);
    } else {
      throw Exception("Unsupported data type");
    }

    print('Data set: Key = $key, Value = $value');
    return result;
  }

  static dynamic getData({
    required String key,
  }) {
    final value = sharedPreferences.get(key);
    print('Data retrieved: Key = $key, Value = $value');
    return value;
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    final result = await sharedPreferences.remove(key);
    print('Data removed: Key = $key');
    return result;
  }

  static setSecuredString({required String key, required String value}) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint(
        "FlutterSecureStorage : setSecuredString with key : $key and value : $value");
    await flutterSecureStorage.write(key: key, value: value);
  }

  static getSecuredString({required String key}) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('FlutterSecureStorage : getSecuredString with key :');
    return await flutterSecureStorage.read(key: key) ?? '';
  }

  static clearAllSecuredData() async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('FlutterSecureStorage : all data has been cleared');
    await flutterSecureStorage.deleteAll();
  }

  // static Future<bool> saveUserData(SeekerData userData) async {
  //   String userDataJson = jsonEncode(userData.toJson());
  //   return await sharedPreferences.setString("seeker_data", userDataJson);
  // }

  // static SeekerData? getUserData() {
  //   String? userDataJson = sharedPreferences.getString("seeker_data");
  //   if (userDataJson == null) return null;
  //   return SeekerData.fromJson(jsonDecode(userDataJson));
  // }

  static Future<bool> removeUserData() async {
    return await sharedPreferences.remove("seeker_data");
  }
}
