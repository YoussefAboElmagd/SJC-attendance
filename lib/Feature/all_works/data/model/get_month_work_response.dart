import 'package:json_annotation/json_annotation.dart';

part 'get_month_work_response.g.dart';

@JsonSerializable()
class WorkDayEntry {
   String? date;

  @JsonKey(name: 'check_in')
   String? checkIn;

  @JsonKey(name: 'check_out')
   String? checkOut;

  @JsonKey(name: 'worked_hours')
   String? workedHours;

  @JsonKey(name: 'in_longitude')
   double? inLongitude;

  @JsonKey(name: 'in_latitude')
   double? inLatitude;

  @JsonKey(name: 'out_longitude')
   double? outLongitude;

  @JsonKey(name: 'out_latitude')
   double? outLatitude;

  WorkDayEntry({
    this.date,
    this.checkIn,
    this.checkOut,
    this.workedHours,
    this.inLongitude,
    this.inLatitude,
    this.outLongitude,
    this.outLatitude,
  });

  factory WorkDayEntry.fromJson(Map<String, dynamic> json) =>
      _$WorkDayEntryFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDayEntryToJson(this);
}
