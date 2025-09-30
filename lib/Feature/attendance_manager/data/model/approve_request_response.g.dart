// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveRequestResponse _$ApproveRequestResponseFromJson(
        Map<String, dynamic> json) =>
    ApproveRequestResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ApproveRequestResponseToJson(
        ApproveRequestResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
