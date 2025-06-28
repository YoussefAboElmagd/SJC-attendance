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
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      dateFrom: json['date_from'] as String?,
      dateTo: json['date_to'] as String?,
      status: json['status'] as String?,
      payslipNet: (json['payslip_net'] as num?)?.toDouble(),
      totalSalary: (json['total_salary'] as num?)?.toDouble(),
      xTotal: (json['x_total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PayslipDetailsDataToJson(PayslipDetailsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date_from': instance.dateFrom,
      'date_to': instance.dateTo,
      'status': instance.status,
      'payslip_net': instance.payslipNet,
      'total_salary': instance.totalSalary,
      'x_total': instance.xTotal,
    };
