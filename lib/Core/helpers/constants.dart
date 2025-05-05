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
}
