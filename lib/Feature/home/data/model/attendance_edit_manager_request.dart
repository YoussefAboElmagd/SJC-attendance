// -----------------------------------------------------------------------------
// File: attendance_edit_manager_request.dart
// Description: This file contains the AttendanceEditManagerRequest class.
// Author: Ahmed Eid
// Changelog:
// 2025-10-21: Ahmed Eid Ibrahim – Created file
// -----------------------------------------------------------------------------
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_edit_manager_request.g.dart';

@JsonSerializable(createFactory: false)
class AttendanceEditManagerRequest {
  @JsonKey(name: "attendance_id")
  final int attendanceId;
  @JsonKey(name: "check_in")
  final String? checkIn;
  @JsonKey(name: "check_out")
  final String? checkOut;
  AttendanceEditManagerRequest({
    required this.attendanceId,
    this.checkIn,
    this.checkOut,
  });
  Map<String, dynamic> toJson() => _$AttendanceEditManagerRequestToJson(this);
}
