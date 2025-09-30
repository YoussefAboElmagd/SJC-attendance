// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_edit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceEditResponse _$AttendanceEditResponseFromJson(
        Map<String, dynamic> json) =>
    AttendanceEditResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      requestId: (json['request_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AttendanceEditResponseToJson(
        AttendanceEditResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'request_id': instance.requestId,
    };
