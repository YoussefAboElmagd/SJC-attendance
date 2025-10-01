// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_exp_categories_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendExpCategResponse _$SendExpCategResponseFromJson(
        Map<String, dynamic> json) =>
    SendExpCategResponse(
      categories: (json['categories'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$SendExpCategResponseToJson(
        SendExpCategResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };
