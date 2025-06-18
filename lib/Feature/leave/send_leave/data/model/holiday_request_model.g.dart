// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HolidayRequestModel _$HolidayRequestModelFromJson(Map<String, dynamic> json) =>
    HolidayRequestModel(
      holidayStatusId: (json['holiday_status_id'] as num?)?.toInt(),
      requestDateFrom: json['request_date_from'] as String?,
      requestDateTo: json['request_date_to'] as String?,
      name: json['name'] as String?,
      requestUnitHalf: json['request_unit_half'] as bool?,
      requestDateFromPeriod: json['request_date_from_period'] as String?,
    );

Map<String, dynamic> _$HolidayRequestModelToJson(
        HolidayRequestModel instance) =>
    <String, dynamic>{
      'holiday_status_id': instance.holidayStatusId,
      'request_date_from': instance.requestDateFrom,
      'request_date_to': instance.requestDateTo,
      'name': instance.name,
      'request_unit_half': instance.requestUnitHalf,
      'request_date_from_period': instance.requestDateFromPeriod,
    };
