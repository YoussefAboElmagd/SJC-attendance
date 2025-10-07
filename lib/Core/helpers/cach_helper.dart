import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? _sharedPreferences;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// Initialize both SharedPreferences and secure storage
  static Future<void> init() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      // debugPrint('CachHelper: SharedPreferences initialized successfully');
    } catch (e) {
      // debugPrint('CachHelper: Error initializing SharedPreferences: $e');
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
      // print(value);
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
      // debugPrint('CachHelper: Error saving data for key $key: $e');
      rethrow;
    }
  }

  /// Get data from SharedPreferences
  static dynamic getData({required String key}) {
    try {
      _ensureInitialized();
      return _sharedPreferences!.get(key);
    } catch (e) {
      // debugPrint('CachHelper: Error getting data for key $key: $e');
      return null;
    }
  }

  /// Remove data from SharedPreferences
  static Future<bool> removeData({required String key}) async {
    try {
      await _ensureInitialized();
      return await _sharedPreferences!.remove(key);
    } catch (e) {
      // debugPrint('CachHelper: Error removing data for key $key: $e');
      return false;
    }
  }

  /// Clear all data from SharedPreferences
  static Future<bool> clearAll() async {
    try {
      await _ensureInitialized();
      return await _sharedPreferences!.clear();
    } catch (e) {
      // debugPrint('CachHelper: Error clearing all data: $e');
      return false;
    }
  }

  /// Secure Storage Methods
  static Future<void> setSecuredString({
    required String key,
    required String value,
  }) async {
    try {
      // debugPrint('SecureStorage: Saving key: $key');
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      // debugPrint('SecureStorage: Error saving key $key: $e');
      rethrow;
    }
  }

  static Future<String?> getSecuredString({required String key}) async {
    try {
      // debugPrint('SecureStorage: Reading key: $key');
      return await _secureStorage.read(key: key);
    } catch (e) {
      // debugPrint('SecureStorage: Error reading key $key: $e');
      return null;
    }
  }

  static Future<void> clearAllSecuredData() async {
    try {
      // debugPrint('SecureStorage: Clearing all data');
      await _secureStorage.deleteAll();
    } catch (e) {
      // debugPrint('SecureStorage: Error clearing all data: $e');
      rethrow;
    }
  }

  static Future<void> _ensureInitialized() async {
    if (_sharedPreferences == null) {
      await init();
    }
  }

  static Future<void> saveUserCredentials({
    required String email,
    required String password,
  }) async {
    try {
      final existingUsers = await getSavedUsers();
      final existingUserIndex = existingUsers.indexWhere(
        (user) => user['email'] == email,
      );
      if (existingUserIndex != -1) {
        existingUsers[existingUserIndex] = {
          'email': email,
          'password': password,
          'lastLogin': DateTime.now().toIso8601String(),
        };
      } else {
        existingUsers.add({
          'email': email,
          'password': password,
          'lastLogin': DateTime.now().toIso8601String(),
        });
      }

      await _saveUserList(existingUsers);
      // debugPrint('CachHelper: User credentials saved for: $email');
    } catch (e) {
      // debugPrint('CachHelper: Error saving user credentials: $e');
      rethrow;
    }
  }

  static Future<List<Map<String, String>>> getSavedUsers() async {
    try {
      final usersJson = getData(key: SharedKeys.savedUsers) as String?;
      if (usersJson == null || usersJson.isEmpty) {
        return [];
      }

      final List<dynamic> usersList = json.decode(usersJson);
      return usersList.map((user) {
        return {
          'email': user['email'] as String,
          'password': user['password'] as String,
          'lastLogin': user['lastLogin'] as String,
        };
      }).toList();
    } catch (e) {
      // debugPrint('CachHelper: Error getting saved users: $e');
      return [];
    }
  }

  static Future<Map<String, String>?> getLastUser() async {
    try {
      final users = await getSavedUsers();
      if (users.isEmpty) return null;

      users.sort((a, b) {
        final dateA = DateTime.parse(a['lastLogin']!);
        final dateB = DateTime.parse(b['lastLogin']!);
        return dateB.compareTo(dateA);
      });

      return users.first;
    } catch (e) {
      // debugPrint('CachHelper: Error getting last user: $e');
      return null;
    }
  }

  static Future<void> removeUser(String email) async {
    try {
      final users = await getSavedUsers();
      users.removeWhere((user) => user['email'] == email);
      await _saveUserList(users);
      // debugPrint('CachHelper: User removed: $email');
    } catch (e) {
      // debugPrint('CachHelper: Error removing user: $e');
      rethrow;
    }
  }

  static Future<void> clearAllUsers() async {
    try {
      await removeData(key: SharedKeys.savedUsers);
      // debugPrint('CachHelper: All users cleared');
    } catch (e) {
      // debugPrint('CachHelper: Error clearing all users: $e');
      rethrow;
    }
  }

  static Future<void> _saveUserList(List<Map<String, String>> users) async {
    if (users.length > 5) {
      users.sort((a, b) {
        final dateA = DateTime.parse(a['lastLogin']!);
        final dateB = DateTime.parse(b['lastLogin']!);
        return dateB.compareTo(dateA);
      });
      users.removeRange(5, users.length);
    }

    final usersJson = json.encode(users);
    print("usersJson $usersJson");
    await saveData(key: SharedKeys.savedUsers, value: usersJson);
  }

  static Future<Map<String, String?>> getSavedLoginCredentials() async {
    try {
      final String? email = getData(key: SharedKeys.savedEmail) as String?;
      final String? password = await getSecuredString(
        key: SharedKeys.savedPassword,
      );

      return {'email': email, 'password': password};
    } catch (e) {
      // debugPrint('CachHelper: Error getting saved credentials: $e');
      return {'email': null, 'password': null};
    }
  }
}
