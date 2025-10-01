// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeoff_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeoffTypesResponse _$TimeoffTypesResponseFromJson(
        Map<String, dynamic> json) =>
    TimeoffTypesResponse(
      count: (json['count'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TimeoffTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimeoffTypesResponseToJson(
        TimeoffTypesResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data,
    };

TimeoffTypeModel _$TimeoffTypeModelFromJson(Map<String, dynamic> json) =>
    TimeoffTypeModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      color: json['color'] as String?,
      requiresAllocation: json['requires_allocation'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$TimeoffTypeModelToJson(TimeoffTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'requires_allocation': instance.requiresAllocation,
      'active': instance.active,
    };
