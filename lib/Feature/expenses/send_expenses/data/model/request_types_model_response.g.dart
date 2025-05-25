// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_types_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestTypesModel _$RequestTypesModelFromJson(Map<String, dynamic> json) =>
    RequestTypesModel(
      requestTypes: (json['request_types'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$RequestTypesModelToJson(RequestTypesModel instance) =>
    <String, dynamic>{
      'request_types': instance.requestTypes,
    };
