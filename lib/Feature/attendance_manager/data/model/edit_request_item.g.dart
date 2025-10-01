// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllEditRequestsModel _$GetAllEditRequestsModelFromJson(
        Map<String, dynamic> json) =>
    GetAllEditRequestsModel(
      success: json['success'] as bool?,
      count: (json['count'] as num?)?.toInt(),
      requestItem: (json['requests'] as List<dynamic>?)
          ?.map((e) => RequestItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllEditRequestsModelToJson(
        GetAllEditRequestsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'requests': instance.requestItem,
    };

RequestItem _$RequestItemFromJson(Map<String, dynamic> json) => RequestItem(
      id: (json['id'] as num?)?.toInt(),
      employeeId: (json['employee_id'] as num?)?.toInt(),
      checkInNeW: json['check_in_new'] as String?,
      checkOutNeW: json['check_out_new'] as String?,
      state: json['state'] as String?,
      createdOn: json['created_on'] as String?,
      attendanceId: (json['attendance_id'] as num?)?.toInt(),
      employeeName: json['employee_name'] as String?,
      checkInOld: json['check_in_old'] as String?,
      checkOutOld: json['check_out_old'] as String?,
    );

Map<String, dynamic> _$RequestItemToJson(RequestItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_id': instance.employeeId,
      'attendance_id': instance.attendanceId,
      'employee_name': instance.employeeName,
      'check_in_old': instance.checkInOld,
      'check_out_old': instance.checkOutOld,
      'check_in_new': instance.checkInNeW,
      'check_out_new': instance.checkOutNeW,
      'state': instance.state,
      'created_on': instance.createdOn,
    };
