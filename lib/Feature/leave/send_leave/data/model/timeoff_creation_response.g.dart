// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeoff_creation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeoffCreationResponse _$TimeoffCreationResponseFromJson(
        Map<String, dynamic> json) =>
    TimeoffCreationResponse(
      count: (json['count'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : TimeoffCreationData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimeoffCreationResponseToJson(
        TimeoffCreationResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
    };

TimeoffCreationData _$TimeoffCreationDataFromJson(Map<String, dynamic> json) =>
    TimeoffCreationData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      employeeName: json['employee_name'] as String?,
      holidayType: json['holiday_type'] as String?,
      requestDateFrom: json['request_date_from'] as String?,
      requestDateTo: json['request_date_to'] as String?,
      numberOfDays: (json['number_of_days'] as num?)?.toDouble(),
      state: json['state'] as String?,
      stateDisplay: json['state_display'] as String?,
    );

Map<String, dynamic> _$TimeoffCreationDataToJson(
        TimeoffCreationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'employee_name': instance.employeeName,
      'holiday_type': instance.holidayType,
      'request_date_from': instance.requestDateFrom,
      'request_date_to': instance.requestDateTo,
      'number_of_days': instance.numberOfDays,
      'state': instance.state,
      'state_display': instance.stateDisplay,
    };
