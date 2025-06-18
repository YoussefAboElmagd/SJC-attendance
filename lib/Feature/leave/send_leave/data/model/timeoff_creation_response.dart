import 'package:json_annotation/json_annotation.dart';

part 'timeoff_creation_response.g.dart';

@JsonSerializable()
class TimeoffCreationResponse {
  @JsonKey(name: 'count')
  int? count;
  
  @JsonKey(name: 'data')
  TimeoffCreationData? data;

  TimeoffCreationResponse({
    this.count,
    this.data,
  });

  factory TimeoffCreationResponse.fromJson(Map<String, dynamic> json) =>
      _$TimeoffCreationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TimeoffCreationResponseToJson(this);
}

@JsonSerializable()
class TimeoffCreationData {
  @JsonKey(name: 'id')
  int? id;
  
  @JsonKey(name: 'name')
  String? name;
  
  @JsonKey(name: 'employee_name')
  String? employeeName;
  
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

  TimeoffCreationData({
    this.id,
    this.name,
    this.employeeName,
    this.holidayType,
    this.requestDateFrom,
    this.requestDateTo,
    this.numberOfDays,
    this.state,
    this.stateDisplay,
  });

  factory TimeoffCreationData.fromJson(Map<String, dynamic> json) =>
      _$TimeoffCreationDataFromJson(json);

  Map<String, dynamic> toJson() => _$TimeoffCreationDataToJson(this);
}