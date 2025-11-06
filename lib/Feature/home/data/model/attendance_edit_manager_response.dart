// -----------------------------------------------------------------------------
// File: attendance_edit_manager_response.dart
// Description: This file contains the AttendanceEditManagerResponse class.
// Author: Ahmed Eid
// Changelog:
// 2025-10-21: Ahmed Eid Ibrahim – Created file
// -----------------------------------------------------------------------------

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_edit_manager_response.g.dart';

@JsonSerializable(createToJson: false)
class AttendanceEditManagerResponse {
  final bool success;
  final String message;
  @JsonKey(name: 'attendance_id')
  final int attendanceId;
  @JsonKey(name: 'employee_id')
  final int employeeId;
  @JsonKey(name: 'check_in')
  final String checkIn;
  @JsonKey(name: 'check_out')
  final String checkOut;

  const AttendanceEditManagerResponse({
    required this.success,
    required this.message,
    required this.attendanceId,
    required this.employeeId,
    required this.checkIn,
    required this.checkOut,
  });

  factory AttendanceEditManagerResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEditManagerResponseFromJson(json);
}
