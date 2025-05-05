// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_month_work_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkDayEntry _$WorkDayEntryFromJson(Map<String, dynamic> json) => WorkDayEntry(
      date: json['date'] as String?,
      checkIn: json['check_in'] as String?,
      checkOut: json['check_out'] as String?,
      workedHours: json['worked_hours'] as String?,
      inLongitude: (json['in_longitude'] as num?)?.toDouble(),
      inLatitude: (json['in_latitude'] as num?)?.toDouble(),
      outLongitude: (json['out_longitude'] as num?)?.toDouble(),
      outLatitude: (json['out_latitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WorkDayEntryToJson(WorkDayEntry instance) =>
    <String, dynamic>{
      'date': instance.date,
      'check_in': instance.checkIn,
      'check_out': instance.checkOut,
      'worked_hours': instance.workedHours,
      'in_longitude': instance.inLongitude,
      'in_latitude': instance.inLatitude,
      'out_longitude': instance.outLongitude,
      'out_latitude': instance.outLatitude,
    };
