// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_me_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMeResponse _$GetMeResponseFromJson(Map<String, dynamic> json) =>
    GetMeResponse(
      code: (json['code'] as num?)?.toInt(),
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : SeekerData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMeResponseToJson(GetMeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

SeekerData _$SeekerDataFromJson(Map<String, dynamic> json) => SeekerData(
      seekerId: (json['seeker_id'] as num?)?.toInt(),
      username: json['username'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      googleId: json['google_id'] as String?,
      profileImage: json['profile_image'] as String?,
      bankAccountNumber: json['bank_account_number'] as String?,
      isPhoneVerified: json['is_phone_verified'] as bool?,
      isAccountActive: json['is_account_active'] as bool?,
      deviceToken: json['device_token'] as String?,
      isOnline: json['is_online'] as bool?,
      lastOnlineTime: json['last_online_time'] as String?,
      country: json['country'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$SeekerDataToJson(SeekerData instance) =>
    <String, dynamic>{
      'seeker_id': instance.seekerId,
      'username': instance.username,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'google_id': instance.googleId,
      'profile_image': instance.profileImage,
      'bank_account_number': instance.bankAccountNumber,
      'is_phone_verified': instance.isPhoneVerified,
      'is_account_active': instance.isAccountActive,
      'device_token': instance.deviceToken,
      'is_online': instance.isOnline,
      'last_online_time': instance.lastOnlineTime,
      'country': instance.country,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
