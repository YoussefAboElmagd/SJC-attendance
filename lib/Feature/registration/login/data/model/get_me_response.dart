import 'package:json_annotation/json_annotation.dart';

part 'get_me_response.g.dart';

@JsonSerializable()
class GetMeResponse {
  final int? code;
  final String? status;
  final String? message;
  final SeekerData? data;

  GetMeResponse({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory GetMeResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMeResponseToJson(this);
}

@JsonSerializable()
class SeekerData {
  @JsonKey(name: 'seeker_id')
  final int? seekerId;

  final String? username;
  final String? email;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'google_id')
  final String? googleId;

  @JsonKey(name: 'profile_image')
  final String? profileImage;

  @JsonKey(name: 'bank_account_number')
  final String? bankAccountNumber;

  @JsonKey(name: 'is_phone_verified')
  final bool? isPhoneVerified;

  @JsonKey(name: 'is_account_active')
  final bool? isAccountActive;

  @JsonKey(name: 'device_token')
  final String? deviceToken;

  @JsonKey(name: 'is_online')
  final bool? isOnline;

  @JsonKey(name: 'last_online_time')
  final String? lastOnlineTime;

  final String? country;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  SeekerData({
    this.seekerId,
    this.username,
    this.email,
    this.phoneNumber,
    this.googleId,
    this.profileImage,
    this.bankAccountNumber,
    this.isPhoneVerified,
    this.isAccountActive,
    this.deviceToken,
    this.isOnline,
    this.lastOnlineTime,
    this.country,
    this.createdAt,
    this.updatedAt,
  });

  factory SeekerData.fromJson(Map<String, dynamic> json) =>
      _$SeekerDataFromJson(json);

  Map<String, dynamic> toJson() => _$SeekerDataToJson(this);
}
