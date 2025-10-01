import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? _sharedPreferences;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// Initialize both SharedPreferences and secure storage
  static Future<void> init() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      debugPrint('CachHelper: SharedPreferences initialized successfully');
    } catch (e) {
      debugPrint('CachHelper: Error initializing SharedPreferences: $e');
      rethrow;
    }
  }

  /// Save data to SharedPreferences with type safety
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    try {
      await _ensureInitialized();

      if (value is String) {
        return await _sharedPreferences!.setString(key, value);
      } else if (value is int) {
        return await _sharedPreferences!.setInt(key, value);
      } else if (value is bool) {
        return await _sharedPreferences!.setBool(key, value);
      } else if (value is double) {
        return await _sharedPreferences!.setDouble(key, value);
      } else if (value == null) {
        return await _sharedPreferences!.remove(key);
      } else {
        throw ArgumentError('Unsupported data type: ${value.runtimeType}');
      }
    } catch (e) {
      debugPrint('CachHelper: Error saving data for key $key: $e');
      rethrow;
    }
  }

  /// Get data from SharedPreferences
  static dynamic getData({required String key}) {
    try {
      _ensureInitialized();
      return _sharedPreferences!.get(key);
    } catch (e) {
      debugPrint('CachHelper: Error getting data for key $key: $e');
      return null;
    }
  }

  /// Remove data from SharedPreferences
  static Future<bool> removeData({required String key}) async {
    try {
      await _ensureInitialized();
      return await _sharedPreferences!.remove(key);
    } catch (e) {
      debugPrint('CachHelper: Error removing data for key $key: $e');
      return false;
    }
  }

  /// Clear all data from SharedPreferences
  static Future<bool> clearAll() async {
    try {
      await _ensureInitialized();
      return await _sharedPreferences!.clear();
    } catch (e) {
      debugPrint('CachHelper: Error clearing all data: $e');
      return false;
    }
  }

  /// Secure Storage Methods
  static Future<void> setSecuredString({
    required String key,
    required String value,
  }) async {
    try {
      debugPrint('SecureStorage: Saving key: $key');
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      debugPrint('SecureStorage: Error saving key $key: $e');
      rethrow;
    }
  }

  static Future<String?> getSecuredString({required String key}) async {
    try {
      debugPrint('SecureStorage: Reading key: $key');
      return await _secureStorage.read(key: key);
    } catch (e) {
      debugPrint('SecureStorage: Error reading key $key: $e');
      return null;
    }
  }

  static Future<void> clearAllSecuredData() async {
    try {
      debugPrint('SecureStorage: Clearing all data');
      await _secureStorage.deleteAll();
    } catch (e) {
      debugPrint('SecureStorage: Error clearing all data: $e');
      rethrow;
    }
  }

  /// Helper method to ensure initialization
  static Future<void> _ensureInitialized() async {
    if (_sharedPreferences == null) {
      await init();
    }
  }
}
// // // import 'package:shared_preferences/shared_preferences.dart';

// // // class CachHelper {
// // //   static late SharedPreferences sharedPreferences;

// // //   static init() async {
// // //     sharedPreferences = await SharedPreferences.getInstance();
// // //   }

// // //   static Future<bool> saveData({
// // //     required dynamic value,
// // //     required String key,
// // //   }) async {
// // //     if (value is String) {
// // //       return await sharedPreferences.setString(key, value);
// // //     }
// // //     if (value is int) {
// // //       return await sharedPreferences.setInt(key, value);
// // //     }
// // //     if (value is bool) {
// // //       return await sharedPreferences.setBool(key, value);
// // //     }
// // //     return await sharedPreferences.setDouble(key, value);
// // //   }

// // //   static dynamic getData({
// // //     required String key,
// // //   }) {
// // //     return sharedPreferences.get(key);
// // //   }

// // //   static dynamic removeData({
// // //     required String key,
// // //   }) {
// // //     return sharedPreferences.remove(key);
// // //   }
// // // }
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
// //     bool result;
// //     if (value is String) {
// //       result = await sharedPreferences.setString(key, value);
// //     } else if (value is int) {
// //       result = await sharedPreferences.setInt(key, value);
// //     } else if (value is bool) {
// //       result = await sharedPreferences.setBool(key, value);
// //     } else if (value is double) {
// //       result = await sharedPreferences.setDouble(key, value);
// //     } else {
// //       throw Exception("Unsupported data type");
// //     }

// //     print('Data set: Key = $key, Value = $value');
// //     return result;
// //   }

// //   static dynamic getData({
// //     required String key,
// //   }) {
// //     final value = sharedPreferences.get(key);
// //     print('Data retrieved: Key = $key, Value = $value');
// //     return value;
// //   }

// //   static Future<bool> removeData({
// //     required String key,
// //   }) async {
// //     final result = await sharedPreferences.remove(key);
// //     print('Data removed: Key = $key');
// //     return result;
// //   }
// // }
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
// // import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import 'package:labaiik_mo3tmer/Features/registration/login/data/model/get_me_response.dart';
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

//   static setSecuredString({required String key, required String value}) async {
//     const flutterSecureStorage = FlutterSecureStorage();
//     debugPrint(
//         "FlutterSecureStorage : setSecuredString with key : $key and value : $value");
//     await flutterSecureStorage.write(key: key, value: value);
//   }

//   static getSecuredString({required String key}) async {
//     const flutterSecureStorage = FlutterSecureStorage();
//     debugPrint('FlutterSecureStorage : getSecuredString with key :');
//     return await flutterSecureStorage.read(key: key) ?? '';
//   }

//   static clearAllSecuredData() async {
//     const flutterSecureStorage = FlutterSecureStorage();
//     debugPrint('FlutterSecureStorage : all data has been cleared');
//     await flutterSecureStorage.deleteAll();
//   }

//   // static Future<bool> saveUserData(SeekerData userData) async {
//   //   String userDataJson = jsonEncode(userData.toJson());
//   //   return await sharedPreferences.setString("seeker_data", userDataJson);
//   // }

//   // static SeekerData? getUserData() {
//   //   String? userDataJson = sharedPreferences.getString("seeker_data");
//   //   if (userDataJson == null) return null;
//   //   return SeekerData.fromJson(jsonDecode(userDataJson));
//   // }

//   static Future<bool> removeUserData() async {
//     return await sharedPreferences.remove("seeker_data");
//   }
// }
