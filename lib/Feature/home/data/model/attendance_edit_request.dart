
// 2. Create Request Model (attendance_edit_request.dart)
import 'package:json_annotation/json_annotation.dart';

part 'attendance_edit_request.g.dart';

@JsonSerializable()
class AttendanceEditRequest {
  @JsonKey(name: 'attendance_id')
  final int attendanceId;

  AttendanceEditRequest({required this.attendanceId});

  factory AttendanceEditRequest.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceEditRequestToJson(this);
}