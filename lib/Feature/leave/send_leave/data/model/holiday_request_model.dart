import 'package:json_annotation/json_annotation.dart';

part 'holiday_request_model.g.dart';

@JsonSerializable()
class HolidayRequestModel {
  @JsonKey(name: 'holiday_status_id')
  int? holidayStatusId;

  @JsonKey(name: 'request_date_from')
  String? requestDateFrom;

  @JsonKey(name: 'request_date_to')
  String? requestDateTo;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'request_unit_half')
  bool? requestUnitHalf;

  @JsonKey(name: 'request_date_from_period')
  String? requestDateFromPeriod;

  HolidayRequestModel({
    this.holidayStatusId,
    this.requestDateFrom,
    this.requestDateTo,
    this.name,
    this.requestUnitHalf,
    this.requestDateFromPeriod,
  });

  factory HolidayRequestModel.fromJson(Map<String, dynamic> json) =>
      _$HolidayRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$HolidayRequestModelToJson(this);
}