import 'package:json_annotation/json_annotation.dart';

part 'holiday_request.g.dart';

@JsonSerializable()
class HolidayRequestResponse {
  int? count;
  List<HolidayRequestData>? data;

  HolidayRequestResponse({this.count, this.data});

  factory HolidayRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$HolidayRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HolidayRequestResponseToJson(this);
}

@JsonSerializable()
class HolidayRequestData {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'holiday_type')
  String? holidayType;

  @JsonKey(name: 'request_date_from')
  String? requestDateFrom;

  @JsonKey(name: 'request_date_to')
  String? requestDateTo;

  @JsonKey(name: 'number_of_days')
  double? numberOfDays;

  @JsonKey(name: 'state')
  String? state;

  @JsonKey(name: 'state_display')
  String? stateDisplay;

  @JsonKey(name: 'create_date')
  String? createDate;

  HolidayRequestData({
    this.id,
    this.name,
    this.holidayType,
    this.requestDateFrom,
    this.requestDateTo,
    this.numberOfDays,
    this.state,
    this.stateDisplay,
    this.createDate,
  });

  factory HolidayRequestData.fromJson(Map<String, dynamic> json) =>
      _$HolidayRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$HolidayRequestDataToJson(this);
}