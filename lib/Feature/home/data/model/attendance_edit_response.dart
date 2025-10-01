
// 3. Create Response Model (attendance_edit_response.dart)
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_edit_response.g.dart';


@JsonSerializable()
class AttendanceEditResponse {
  final bool? success;
  final String? message;
  @JsonKey(name: 'request_id')
  final int? requestId;

  AttendanceEditResponse({this.success, this.message, this.requestId});

  factory AttendanceEditResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEditResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceEditResponseToJson(this);
}