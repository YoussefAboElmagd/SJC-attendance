// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_today_work_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayWorkDayEntry _$TodayWorkDayEntryFromJson(Map<String, dynamic> json) =>
    TodayWorkDayEntry(
      checkIn: json['check_in'] as String?,
      checkOut: json['check_out'] as String?,
      workedHours: json['worked_hours'] as String?,
      inLongitude: (json['in_longitude'] as num?)?.toDouble(),
      inLatitude: (json['in_latitude'] as num?)?.toDouble(),
      outLongitude: (json['out_longitude'] as num?)?.toDouble(),
      outLatitude: (json['out_latitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TodayWorkDayEntryToJson(TodayWorkDayEntry instance) =>
    <String, dynamic>{
      'check_in': instance.checkIn,
      'check_out': instance.checkOut,
      'worked_hours': instance.workedHours,
      'in_longitude': instance.inLongitude,
      'in_latitude': instance.inLatitude,
      'out_longitude': instance.outLongitude,
      'out_latitude': instance.outLatitude,
    };
