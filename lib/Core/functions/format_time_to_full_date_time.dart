// -----------------------------------------------------------------------------
// File: format_time_to_full_date_time.dart
// Description: function to convert "06:44 PM" or "18:44" to "2025-10-21 18:44:00"
// Author(s): Ahmed Eid Ibrahim
// Created: 2025-10-21
// Changelog:
// 2025-10-21: Ahmed Eid Ibrahim – Created file
// -----------------------------------------------------------------------------

import 'package:intl/intl.dart';

/// Converts a time string like "06:44 PM" or "18:44"
/// into a full datetime string "2025-10-21 18:44:00"
/// Always uses English locale (en_US)
String formatTimeToFullDateTime(String timeString, {DateTime? date}) {
  final now = date ?? DateTime.now();

  // Normalize and uppercase input
  final input = timeString.trim().toUpperCase();

  int hour = 0;
  int minute = 0;

  try {
    if (input.contains('AM') || input.contains('PM')) {
      // Manually handle 12-hour format to avoid locale issues
      final parts = input
          .replaceAll('AM', '')
          .replaceAll('PM', '')
          .trim()
          .split(':');

      hour = int.parse(parts[0]) % 12;
      minute = int.parse(parts[1]);
      if (input.contains('PM')) hour += 12;
    } else {
      // Handle 24-hour format
      final parts = input.split(':');
      hour = int.parse(parts[0]);
      minute = int.parse(parts[1]);
    }
  } catch (_) {
    throw FormatException('Invalid time format: $timeString');
  }

  final combined = DateTime(now.year, now.month, now.day, hour, minute);

  // Force English locale in formatting
  final formatter = DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US');
  return formatter.format(combined);
}
