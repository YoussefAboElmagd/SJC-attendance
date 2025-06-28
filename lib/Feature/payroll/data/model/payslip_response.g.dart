// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payslip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayslipResponse _$PayslipResponseFromJson(Map<String, dynamic> json) =>
    PayslipResponse(
      count: (json['count'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PayslipData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PayslipResponseToJson(PayslipResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
    };

PayslipData _$PayslipDataFromJson(Map<String, dynamic> json) => PayslipData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PayslipDataToJson(PayslipData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
