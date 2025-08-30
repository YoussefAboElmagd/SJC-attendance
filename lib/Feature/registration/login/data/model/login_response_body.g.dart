// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseBody _$LoginResponseBodyFromJson(Map<String, dynamic> json) =>
    LoginResponseBody(
      uid: (json['uid'] as num).toInt(),
      access: Access.fromJson(json['access'] as Map<String, dynamic>),
      companyId: (json['company_id'] as num).toInt(),
      companyIds: (json['company_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      partnerId: (json['partner_id'] as num).toInt(),
      accessToken: json['access_token'] as String,
      companyName: json['company_name'],
      country: json['country'],
      contactAddress: json['contact_address'] as String,
    );

Map<String, dynamic> _$LoginResponseBodyToJson(LoginResponseBody instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'company_id': instance.companyId,
      'company_ids': instance.companyIds,
      'partner_id': instance.partnerId,
      'access_token': instance.accessToken,
      'company_name': instance.companyName,
      'country': instance.country,
      'contact_address': instance.contactAddress,
      'access': instance.access,
    };

Access _$AccessFromJson(Map<String, dynamic> json) => Access(
      attendance: json['attendance'] as String?,
      expenses: json['expenses'] as String?,
      payroll: json['payroll'] as String?,
      timeoff: json['timeoff'] as String?,
      skipBiometric: json['skip_biometric'] as bool?,
    );

Map<String, dynamic> _$AccessToJson(Access instance) => <String, dynamic>{
      'attendance': instance.attendance,
      'expenses': instance.expenses,
      'payroll': instance.payroll,
      'timeoff': instance.timeoff,
      'skip_biometric': instance.skipBiometric,
    };
