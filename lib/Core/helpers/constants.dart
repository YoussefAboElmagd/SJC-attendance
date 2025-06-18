import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class AppConstants {
  static bool isLogged = false;
  static bool isThird = false;
  static bool isArabic = false;
  static bool isBoarding = false;
  static bool isIhram = false;
  static bool isSaee = false;
  static bool isTawaf = false;
  static String selectedPrefix = "+20";
  static String? fcmToken;
  static String? userToken;
  static LocationData? locationData;
  List<String> countryImages = [
    "assets/images/england.jpg",
    "assets/images/egypt.jpg",
  ];
  static DateTime? startDate;
  static DateTime? endDate;

  // static bool isArabic() {
  //   return Intl.getCurrentLocale() == 'ar';
  // }

  static dynamic Function(String?) normalValidator({
    required BuildContext context,
    String? warning,
  }) => (String? value) {
    if (value == null || value.isEmpty || value.trim() == '') {
      return warning ?? 'يجب ملئ هذا الحقل';
    }
  };

  static dynamic Function(String?) phoneValidator({
    required BuildContext context,
    String? warning,
  }) => (String? value) {
    if (value == null || value.isEmpty || value.trim() == '') {
      return warning ?? 'يجب ملئ هذا الحقل';
    }
    if (!value.startsWith('01')) {
      return 'The phone number must start with 01';
    }
    if (value.length != 11) {
      return 'The phone number must be 11 digits';
    }
  };
  static dynamic Function(String?) passwrodValidator({
    required BuildContext context,
  }) => (String? value) {
    if (value == null || value.isEmpty || value.trim() == '') {
      return 'يجب ملئ هذا الحقل';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
  };
  static dynamic Function(String?) confrimPasswordValidation({
    required BuildContext context,
    required String password,
  }) => (String? value) {
    if (value == null || value.isEmpty || value.trim() == '') {
      return 'يجب ملئ هذا الحقل';
    }
    if (password != value) {
      return 'Passwords do not match';
    }
  };
  static String? Function(String?)? dropDownListValidation({
    required BuildContext context,
    String? warning,
  }) => (String? value) {
    if (value == null || value.isEmpty || value.trim() == '') {
      return warning ?? 'يجب ملئ هذا الحقل';
    }
    return null;
  };
}
