import 'package:json_annotation/json_annotation.dart';

part 'total_hours.g.dart';

@JsonSerializable()
class TotalHours {
  @JsonKey(name: 'total_hours')
  String? totalHours;

  TotalHours({required this.totalHours});

  factory TotalHours.fromJson(Map<String, dynamic> json) =>
      _$TotalHoursFromJson(json);
  Map<String, dynamic> toJson() => _$TotalHoursToJson(this);
}
