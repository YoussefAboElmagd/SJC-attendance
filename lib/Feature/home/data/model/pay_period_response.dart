import 'package:json_annotation/json_annotation.dart';

part 'pay_period_response.g.dart';

@JsonSerializable()
class PayPeriodResponse {
  @JsonKey(name: 'total_time_for_this_month')
  String? totalTimeForThisMonth;

  PayPeriodResponse({required this.totalTimeForThisMonth});

  factory PayPeriodResponse.fromJson(Map<String, dynamic> json) =>
      _$PayPeriodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PayPeriodResponseToJson(this);
}
