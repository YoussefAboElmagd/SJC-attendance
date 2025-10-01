import 'package:json_annotation/json_annotation.dart';

part 'payslip_details_response.g.dart';

@JsonSerializable()
class PayslipDetailsResponse {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'data')
  final PayslipDetailsData? data;

  PayslipDetailsResponse({this.status, this.data});

  factory PayslipDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PayslipDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipDetailsResponseToJson(this);
}

@JsonSerializable()
class PayslipDetailsData {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'period')
  final String? period;

  @JsonKey(name: 'net_salary')
  final double? netSalary;

  @JsonKey(name: 'state')
  final String? state;

  @JsonKey(name: 'lines')
  final List<Lines>? lines;

  PayslipDetailsData({
    this.period,
    this.netSalary,
    this.state,
    this.lines,
    this.status,
  });

  factory PayslipDetailsData.fromJson(Map<String, dynamic> json) =>
      _$PayslipDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$PayslipDetailsDataToJson(this);
}

@JsonSerializable()
class Lines {
  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'total')
  final double? total;

  @JsonKey(name: 'amount')
  final double? amount;

  @JsonKey(name: 'quantity')
  final double? quantity;

  @JsonKey(name: 'rate')
  final double? rate;

  Lines({
    this.code,
    this.name,
    this.category,
    this.total,
    this.amount,
    this.quantity,
    this.rate,
  });

  factory Lines.fromJson(Map<String, dynamic> json) => _$LinesFromJson(json);

  Map<String, dynamic> toJson() => _$LinesToJson(this);
}
