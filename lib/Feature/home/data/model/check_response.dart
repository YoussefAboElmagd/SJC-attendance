import 'package:json_annotation/json_annotation.dart';

part 'check_response.g.dart';

@JsonSerializable()
class AttendanceResponse {
  int? count;
  List<AttendanceData>? data;

  AttendanceResponse({
    this.count,
    this.data,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceResponseToJson(this);
}

@JsonSerializable()
class AttendanceData {
  @JsonKey(name: 'attendance_state')
  String? attendanceState;
  String? message;

  AttendanceData({
    this.attendanceState,
    this.message,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDataFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDataToJson(this);
}
