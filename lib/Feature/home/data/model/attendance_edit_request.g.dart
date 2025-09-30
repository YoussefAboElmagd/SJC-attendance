// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_edit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceEditRequest _$AttendanceEditRequestFromJson(
        Map<String, dynamic> json) =>
    AttendanceEditRequest(
      attendanceId: (json['attendance_id'] as num).toInt(),
    );

Map<String, dynamic> _$AttendanceEditRequestToJson(
        AttendanceEditRequest instance) =>
    <String, dynamic>{
      'attendance_id': instance.attendanceId,
    };
