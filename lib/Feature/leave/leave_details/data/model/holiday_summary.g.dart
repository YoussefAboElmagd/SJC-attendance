// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HolidaySummaryResponse _$HolidaySummaryResponseFromJson(
        Map<String, dynamic> json) =>
    HolidaySummaryResponse(
      count: (json['count'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : HolidaySummaryData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HolidaySummaryResponseToJson(
        HolidaySummaryResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
    };

HolidaySummaryData _$HolidaySummaryDataFromJson(Map<String, dynamic> json) =>
    HolidaySummaryData(
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => HolidayType.fromJson(e as Map<String, dynamic>))
          .toList(),
      allAllocated: (json['all_allocated'] as num?)?.toDouble(),
      allRemaining: (json['all_remaining'] as num?)?.toDouble(),
      allSpent: (json['all_spent'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HolidaySummaryDataToJson(HolidaySummaryData instance) =>
    <String, dynamic>{
      'types': instance.types,
      'all_allocated': instance.allAllocated,
      'all_spent': instance.allSpent,
      'all_remaining': instance.allRemaining,
    };

HolidayType _$HolidayTypeFromJson(Map<String, dynamic> json) => HolidayType(
      holidayTypeId: (json['holiday_type_id'] as num?)?.toInt(),
      holidayTypeName: json['holiday_type_name'] as String?,
      totalAllocated: (json['total_allocated'] as num?)?.toDouble(),
      totalSpent: (json['total_spent'] as num?)?.toDouble(),
      remainingDays: (json['remaining_days'] as num?)?.toDouble(),
      color: json['color'] as String?,
    );

Map<String, dynamic> _$HolidayTypeToJson(HolidayType instance) =>
    <String, dynamic>{
      'holiday_type_id': instance.holidayTypeId,
      'holiday_type_name': instance.holidayTypeName,
      'total_allocated': instance.totalAllocated,
      'total_spent': instance.totalSpent,
      'remaining_days': instance.remainingDays,
      'color': instance.color,
    };
