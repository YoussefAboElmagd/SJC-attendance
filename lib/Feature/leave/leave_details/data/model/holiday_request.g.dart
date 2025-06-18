// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HolidayRequestResponse _$HolidayRequestResponseFromJson(
        Map<String, dynamic> json) =>
    HolidayRequestResponse(
      count: (json['count'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HolidayRequestData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HolidayRequestResponseToJson(
        HolidayRequestResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
    };

HolidayRequestData _$HolidayRequestDataFromJson(Map<String, dynamic> json) =>
    HolidayRequestData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      holidayType: json['holiday_type'] as String?,
      requestDateFrom: json['request_date_from'] as String?,
      requestDateTo: json['request_date_to'] as String?,
      numberOfDays: (json['number_of_days'] as num?)?.toDouble(),
      state: json['state'] as String?,
      stateDisplay: json['state_display'] as String?,
      createDate: json['create_date'] as String?,
    );

Map<String, dynamic> _$HolidayRequestDataToJson(HolidayRequestData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'holiday_type': instance.holidayType,
      'request_date_from': instance.requestDateFrom,
      'request_date_to': instance.requestDateTo,
      'number_of_days': instance.numberOfDays,
      'state': instance.state,
      'state_display': instance.stateDisplay,
      'create_date': instance.createDate,
    };
