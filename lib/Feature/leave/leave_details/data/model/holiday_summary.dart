import 'package:json_annotation/json_annotation.dart';

part 'holiday_summary.g.dart';

@JsonSerializable()
class HolidaySummaryResponse {
  int? count;
  HolidaySummaryData? data;

  HolidaySummaryResponse({this.count, this.data});

  factory HolidaySummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$HolidaySummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HolidaySummaryResponseToJson(this);
}

@JsonSerializable()
class HolidaySummaryData {
  List<HolidayType>? types;
  @JsonKey(name: "all_allocated")
  double? allAllocated;
  @JsonKey(name: "all_spent")
  double? allSpent;
  @JsonKey(name: "all_remaining")
  double? allRemaining;

  HolidaySummaryData({
    this.types,
    this.allAllocated,
    this.allRemaining,
    this.allSpent,
  });

  factory HolidaySummaryData.fromJson(Map<String, dynamic> json) =>
      _$HolidaySummaryDataFromJson(json);

  Map<String, dynamic> toJson() => _$HolidaySummaryDataToJson(this);
}

@JsonSerializable()
class HolidayType {
  @JsonKey(name: 'holiday_type_id')
  int? holidayTypeId;

  @JsonKey(name: 'holiday_type_name')
  String? holidayTypeName;

  @JsonKey(name: 'total_allocated')
  double? totalAllocated;

  @JsonKey(name: 'total_spent')
  double? totalSpent;

  @JsonKey(name: 'remaining_days')
  double? remainingDays;

  @JsonKey(name: 'color')
  String? color;

  HolidayType({
    this.holidayTypeId,
    this.holidayTypeName,
    this.totalAllocated,
    this.totalSpent,
    this.remainingDays,
    this.color,
  });

  factory HolidayType.fromJson(Map<String, dynamic> json) =>
      _$HolidayTypeFromJson(json);

  Map<String, dynamic> toJson() => _$HolidayTypeToJson(this);
}