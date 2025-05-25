// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_expense_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateExpenseResponse _$CreateExpenseResponseFromJson(
        Map<String, dynamic> json) =>
    CreateExpenseResponse(
      success: json['success'] as bool?,
      attachmentId: json['attachment_id'],
      recordId: json['record_id'] as String?,
    );

Map<String, dynamic> _$CreateExpenseResponseToJson(
        CreateExpenseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'record_id': instance.recordId,
      'attachment_id': instance.attachmentId,
    };
