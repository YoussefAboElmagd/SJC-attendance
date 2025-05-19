// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckRequest _$CheckRequestFromJson(Map<String, dynamic> json) => CheckRequest(
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      ipAddress: json['ip_address'] as String?,
      uuid: json['uuid'] as String?,
    );

Map<String, dynamic> _$CheckRequestToJson(CheckRequest instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'ip_address': instance.ipAddress,
      'uuid': instance.uuid,
    };
