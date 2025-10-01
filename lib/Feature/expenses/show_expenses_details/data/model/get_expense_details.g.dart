// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_expense_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseDetailsResponse _$ExpenseDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ExpenseDetailsResponse(
      data: json['data'] == null
          ? null
          : ExpenseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExpenseDetailsResponseToJson(
        ExpenseDetailsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ExpenseData _$ExpenseDataFromJson(Map<String, dynamic> json) => ExpenseData(
      id: (json['id'] as num?)?.toInt(),
      description: json['description'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      messages: json['messages'] as List<dynamic>?,
      requestTypeId: (json['request_type_id'] as num?)?.toInt(),
      state: json['state'] as String?,
      date: json['date'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..categoryName = json['category_name'] as String?
      ..requestName = json['request_type_name'] as String?
      ..rejectReason = json['reject_reason'] as String?;

Map<String, dynamic> _$ExpenseDataToJson(ExpenseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'request_type_id': instance.requestTypeId,
      'request_type_name': instance.requestName,
      'state': instance.state,
      'date': instance.date,
      'reject_reason': instance.rejectReason,
      'total_amount': instance.totalAmount,
      'attachments': instance.attachments,
      'messages': instance.messages,
    };

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      name: json['name'] as String?,
      mimetype: json['mimetype'] as String?,
      base64: json['base64'] as String?,
    )..imageExtension = json['extension'] as String?;

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mimetype': instance.mimetype,
      'base64': instance.base64,
      'extension': instance.imageExtension,
    };
