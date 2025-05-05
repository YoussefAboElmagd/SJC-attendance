// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceResponse _$AttendanceResponseFromJson(Map<String, dynamic> json) =>
    AttendanceResponse(
      count: (json['count'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AttendanceData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttendanceResponseToJson(AttendanceResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
    };

AttendanceData _$AttendanceDataFromJson(Map<String, dynamic> json) =>
    AttendanceData(
      attendanceState: json['attendance_state'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AttendanceDataToJson(AttendanceData instance) =>
    <String, dynamic>{
      'attendance_state': instance.attendanceState,
      'message': instance.message,
    };
