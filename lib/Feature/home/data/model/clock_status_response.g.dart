// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClockStatusResponse _$ClockStatusResponseFromJson(Map<String, dynamic> json) =>
    ClockStatusResponse(
      attendanceState: json['attendance_state'] as String?,
    );

Map<String, dynamic> _$ClockStatusResponseToJson(
        ClockStatusResponse instance) =>
    <String, dynamic>{
      'attendance_state': instance.attendanceState,
    };
