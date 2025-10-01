// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_holiday_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewHolidayResponse _$NewHolidayResponseFromJson(Map<String, dynamic> json) =>
    NewHolidayResponse(
      count: (json['count'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : HolidayRequestDataWrapper.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewHolidayResponseToJson(NewHolidayResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
    };

HolidayRequestDataWrapper _$HolidayRequestDataWrapperFromJson(
        Map<String, dynamic> json) =>
    HolidayRequestDataWrapper(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HolidayRequestData.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HolidayRequestDataWrapperToJson(
        HolidayRequestDataWrapper instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

PaginationMeta _$PaginationMetaFromJson(Map<String, dynamic> json) =>
    PaginationMeta(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginationMetaToJson(PaginationMeta instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      currentPage: (json['current_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      totalItems: (json['total_items'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      hasNext: json['has_next'] as bool?,
      hasPrev: json['has_prev'] as bool?,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
      'has_next': instance.hasNext,
      'has_prev': instance.hasPrev,
    };

HolidayRequestData _$HolidayRequestDataFromJson(Map<String, dynamic> json) =>
    HolidayRequestData(
      id: (json['id'] as num?)?.toInt(),
      employeeName: json['employee_name'] as String?,
      name: json['name'] as String?,
      holidayType: json['holiday_type'] as String?,
      requestDateFrom: json['request_date_from'] as String?,
      requestDateTo: json['request_date_to'] as String?,
      numberOfDays: (json['number_of_days'] as num?)?.toInt(),
      state: json['state'] as String?,
      stateDisplay: json['state_display'] as String?,
      createDate: json['create_date'] as String?,
    );

Map<String, dynamic> _$HolidayRequestDataToJson(HolidayRequestData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_name': instance.employeeName,
      'name': instance.name,
      'holiday_type': instance.holidayType,
      'request_date_from': instance.requestDateFrom,
      'request_date_to': instance.requestDateTo,
      'number_of_days': instance.numberOfDays,
      'state': instance.state,
      'state_display': instance.stateDisplay,
      'create_date': instance.createDate,
    };
