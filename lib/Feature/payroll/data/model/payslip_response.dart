import 'package:json_annotation/json_annotation.dart';

part 'payslip_response.g.dart';

@JsonSerializable()
class PayslipResponse {
  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'data')
  List<PayslipData>? data;

  PayslipResponse({this.count, this.data});

  factory PayslipResponse.fromJson(Map<String, dynamic> json) =>
      _$PayslipResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipResponseToJson(this);
}

@JsonSerializable()
class PayslipData {
  @JsonKey(name: 'payslip_id')
  int? id;
  @JsonKey(name: 'month')
  String? month;
  @JsonKey(name: 'period')
  String? period;
  @JsonKey(name: 'net_salary')
  double? netSalary;
  @JsonKey(name: 'status')
  String? status;

  PayslipData({
    this.id,
    this.month,
    this.netSalary,
    this.period,
    this.status,
    // this.name,
  });

  factory PayslipData.fromJson(Map<String, dynamic> json) =>
      _$PayslipDataFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipDataToJson(this);
}
