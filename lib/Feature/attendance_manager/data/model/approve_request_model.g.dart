// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveRequestModel _$ApproveRequestModelFromJson(Map<String, dynamic> json) =>
    ApproveRequestModel(
      requestId: (json['request_id'] as num).toInt(),
      checkInNew: json['check_in_new'] as String,
      checkOutNew: json['check_out_new'] as String,
    );

Map<String, dynamic> _$ApproveRequestModelToJson(
        ApproveRequestModel instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'check_in_new': instance.checkInNew,
      'check_out_new': instance.checkOutNew,
    };
