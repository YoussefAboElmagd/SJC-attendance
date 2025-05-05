import 'package:json_annotation/json_annotation.dart';

part 'clock_status_response.g.dart';

@JsonSerializable()
class ClockStatusResponse {
  @JsonKey(name: 'attendance_state')
  String? attendanceState;

  ClockStatusResponse({ this.attendanceState});

  factory ClockStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$ClockStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClockStatusResponseToJson(this);
}
