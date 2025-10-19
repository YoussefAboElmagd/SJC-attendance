import 'package:json_annotation/json_annotation.dart';

part 'login_response_body.g.dart';

@JsonSerializable()
class LoginResponseBody {
  final int uid;
  @JsonKey(name: 'company_id')
  final int companyId;
  @JsonKey(name: 'company_ids')
  final List<int> companyIds;
  @JsonKey(name: 'partner_id')
  final int partnerId;
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'company_name')
  final dynamic companyName;
  final dynamic country;
  @JsonKey(name: 'contact_address')
  final String contactAddress;
  @JsonKey(name: 'access')
  final Access access;

  LoginResponseBody({
    required this.uid,
    required this.access,
    required this.companyId,
    required this.companyIds,
    required this.partnerId,
    required this.accessToken,
    this.companyName,
    this.country,
    required this.contactAddress,
  });

  factory LoginResponseBody.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseBodyToJson(this);
}

@JsonSerializable()
class Access {
  @JsonKey(name: 'attendance')
  final String? attendance;
  //TODO:  user / Manager
  @JsonKey(name: 'expenses')
  final String? expenses;
  @JsonKey(name: 'payroll')
  final String? payroll;
  @JsonKey(name: 'timeoff')
  final String? timeoff;
  @JsonKey(name: 'skip_biometric')
  final bool? skipBiometric;

  Access({
    required this.attendance,
    required this.expenses,
    required this.payroll,
    required this.timeoff,
    required this.skipBiometric,
  });

  factory Access.fromJson(Map<String, dynamic> json) => _$AccessFromJson(json);

  Map<String, dynamic> toJson() => _$AccessToJson(this);
}
