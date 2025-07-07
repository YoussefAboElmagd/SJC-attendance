// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslip_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayslipDetailsResponse _$PayslipDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    PayslipDetailsResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : PayslipDetailsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayslipDetailsResponseToJson(
        PayslipDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

PayslipDetailsData _$PayslipDetailsDataFromJson(Map<String, dynamic> json) =>
    PayslipDetailsData(
      period: json['period'] as String?,
      netSalary: (json['net_salary'] as num?)?.toDouble(),
      state: json['state'] as String?,
      lines: (json['lines'] as List<dynamic>?)
          ?.map((e) => Lines.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PayslipDetailsDataToJson(PayslipDetailsData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'period': instance.period,
      'net_salary': instance.netSalary,
      'state': instance.state,
      'lines': instance.lines,
    };

Lines _$LinesFromJson(Map<String, dynamic> json) => Lines(
      code: json['code'] as String?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      total: (json['total'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      rate: (json['rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LinesToJson(Lines instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'category': instance.category,
      'total': instance.total,
      'amount': instance.amount,
      'quantity': instance.quantity,
      'rate': instance.rate,
    };
