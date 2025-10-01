import 'package:json_annotation/json_annotation.dart';

part 'approve_request_response.g.dart';


@JsonSerializable()
class ApproveRequestResponse {
  final bool? success;
  final String? message;

  ApproveRequestResponse({
    this.success,
    this.message,
  });

  factory ApproveRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$ApproveRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveRequestResponseToJson(this);
}
