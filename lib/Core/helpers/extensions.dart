import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(
    String routeName, {
    Object? arguments,
    bool? routerNavigator,
  }) {
    return Navigator.of(
      this,
      rootNavigator: routerNavigator ?? false,
    ).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntill(
    String routeName, {
    Object? arguments,
    bool? routerNavigator,
    bool Function(Route<dynamic>)? predicate, // Changed this parameter
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      // predicate ?? (route) => false, // Default to remove all routes
      // (route) => routerNavigator ?? false,
      arguments: arguments,
    );
  }

  void pop() => Navigator.of(this).pop();
  void popAlert() => Navigator.of(this, rootNavigator: true).pop();
}

extension StringExtension on String? {
  bool isNotEmptyOrNull() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNotEmptyOrNull() => this == null || this!.isEmpty;
}

extension MapExtension<x, y> on Map<x, y>? {
  bool isNotEmptyOrNull() => this == null || this!.isEmpty;
}

extension DateTimeFormatter on String {
  String toFormattedDate({String locale = 'en'}) {
    DateTime parsedDate = DateTime.parse(this);
    return DateFormat(
      'EEEE, d MMMM yyyy \'at\' h:mm a',
      locale,
    ).format(parsedDate);
  }

  String toFormattedDate2({String locale = 'en'}) {
    DateTime parsedDate = DateTime.parse(this);
    return DateFormat('EEEE, d MMMM yyyy', locale).format(parsedDate);
  }

  /// Extracts the day (1-31) as an integer.
  int? getDay() {
    try {
      return DateTime.parse(this).day;
    } catch (e) {
      return null;
    }
  }

  /// Extracts the month (1-12) as an integer.
  int? getMonth() {
    try {
      return DateTime.parse(this).month;
    } catch (e) {
      return null;
    }
  }

  /// Extracts the year (e.g., 2023) as an integer.
  int? getYear() {
    try {
      return DateTime.parse(this).year;
    } catch (e) {
      return null;
    }
  }

  /// Gets the month name (e.g., "January") as a localized string.
  String? getMonthName({String locale = 'en'}) {
    try {
      return DateFormat('MMMM', locale).format(DateTime.parse(this));
    } catch (e) {
      return null;
    }
  }

  /// Gets the day name (e.g., "Monday") as a localized string.
  String? getDayName({String locale = 'en'}) {
    try {
      return DateFormat('EEEE', locale).format(DateTime.parse(this));
    } catch (e) {
      return null;
    }
  }
}

extension DateTimeFormatter2 on DateTime {
  String formatDateTime2({bool isArabic = false}) {
    // String locale = isArabic ? 'ar' : 'en';
    String amPm = hour >= 12
        ? (isArabic ? "م" : "PM")
        : (isArabic ? "ص" : "AM");
    int formattedHour = hour % 12 == 0 ? 12 : hour % 12;

    String date = isArabic
        ? "${convertToArabic(year)}/${convertToArabic(month)}/${convertToArabic(day)}"
        : "$day/$month/$year";

    String time = isArabic
        ? "${convertToArabic(formattedHour)}:${convertToArabic(minute.toString().padLeft(2, '0'))} $amPm"
        : "$formattedHour:${minute.toString().padLeft(2, '0')} $amPm";

    return "$date\n$time";
  }

  String convertToArabic(dynamic number) {
    final arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number
        .toString()
        .split('')
        .map((char) {
          return char.contains(RegExp(r'[0-9]'))
              ? arabicNumbers[int.parse(char)]
              : char;
        })
        .join('');
  }
}

extension DateTimeExtension on String {
  /// تحويل التاريخ من تنسيق ISO 8601 إلى وقت بتنسيق 12 ساعة (مثل 12:45 pm).
  String toFormattedTime() {
    try {
      // تحويل النص إلى كائن DateTime
      final dateTime = DateTime.parse(this); // تحويل إلى التوقيت المحلي

      // تنسيق الوقت باستخدام DateFormat
      final formattedTime = DateFormat('h:mm a').format(dateTime);

      return formattedTime;
    } catch (e) {
      // في حالة وجود خطأ، يتم إرجاع النص الأصلي
      return this;
    }
  }
}

extension DateRangeFormatter on String {
  String toFormattedDateRange({bool isArabic = false}) {
    try {
      // Handle the format: "2025-06-17T00:00:00.000Z:2025-06-20T00:00:00.000Z"
      final parts = split('Z:');
      if (parts.length != 2) {
        return 'Invalid format';
      }

      // Add back the 'Z' to the first part since split removes it
      final startDateStr = '${parts[0]}Z';
      final endDateStr = parts[1];

      final startDate = DateTime.parse(startDateStr);
      final endDate = DateTime.parse(endDateStr);

      DateFormat formatter;
      if (isArabic) {
        formatter = DateFormat('yyyy-MM-dd');
      } else {
        formatter = DateFormat('dd-MM-yyyy');
      }

      return '${formatter.format(startDate)} : ${formatter.format(endDate)}';
    } catch (e) {
      print('Error formatting date range: $e');
      print('Input string: $this');
      return 'Invalid date format';
    }
  }
}
// extension DateRangeFormatter on String {
//   String toFormattedDateRange({bool isArabic = false}) {
//     try {
//       final parts = split('Z:');
//       if (parts.length != 2) {
//         return 'Invalid format';
//       }

//       final startDate = DateTime.parse(parts[0]);
//       final endDate = DateTime.parse(parts[1]);
//       var formatter;
//       if (isArabic) {
//         formatter = DateFormat('yyyy-MM-dd');
//       } else {
//         formatter = DateFormat('dd-MM-yyyy');
//       }

//       return '${formatter.format(startDate)} : ${formatter.format(endDate)}';
//     } catch (e) {
//       return 'Invalid date format';
//     }
//   }
// }
