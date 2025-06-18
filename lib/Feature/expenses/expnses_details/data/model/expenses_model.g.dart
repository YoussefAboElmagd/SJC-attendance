// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpensesListResponse _$ExpensesListResponseFromJson(
        Map<String, dynamic> json) =>
    ExpensesListResponse(
      results: (json['results'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ExpenseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExpensesListResponseToJson(
        ExpensesListResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'data': instance.data,
    };

ExpenseData _$ExpenseDataFromJson(Map<String, dynamic> json) => ExpenseData(
      name: json['name'] as String?,
      date: json['date'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
    )
      ..id = (json['id'] as num?)?.toInt()
      ..status = json['state'] as String?;

Map<String, dynamic> _$ExpenseDataToJson(ExpenseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date,
      'state': instance.status,
      'total_amount': instance.totalAmount,
    };
