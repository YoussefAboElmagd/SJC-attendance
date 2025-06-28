import 'package:json_annotation/json_annotation.dart';

part 'payslip_details_response.g.dart';

@JsonSerializable()
class PayslipDetailsResponse {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'data')
  final PayslipDetailsData? data;

  PayslipDetailsResponse({
    this.status,
    this.data,
  });

  factory PayslipDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PayslipDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipDetailsResponseToJson(this);
}

@JsonSerializable()
class PayslipDetailsData {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'date_from')
  final String? dateFrom;

  @JsonKey(name: 'date_to')
  final String? dateTo;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'payslip_net')
  final double? payslipNet;

  @JsonKey(name: 'total_salary')
  final double? totalSalary;

  @JsonKey(name: 'x_total')
  final double? xTotal;

  PayslipDetailsData({
    this.id,
    this.name,
    this.dateFrom,
    this.dateTo,
    this.status,
    this.payslipNet,
    this.totalSalary,
    this.xTotal,
  });

  factory PayslipDetailsData.fromJson(Map<String, dynamic> json) =>
      _$PayslipDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipDetailsDataToJson(this);
}