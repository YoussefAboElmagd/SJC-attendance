// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_expense_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateExpenseRequest _$CreateExpenseRequestFromJson(
        Map<String, dynamic> json) =>
    CreateExpenseRequest(
      categoryId: json['category_id'] as String?,
      requestTypeId: json['request_type_id'] as String?,
      description: json['description'] as String?,
      totalAmount: json['total_amount'] as String?,
    );

Map<String, dynamic> _$CreateExpenseRequestToJson(
        CreateExpenseRequest instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'request_type_id': instance.requestTypeId,
      'description': instance.description,
      'total_amount': instance.totalAmount,
    };
