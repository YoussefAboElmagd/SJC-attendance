import 'package:json_annotation/json_annotation.dart';

part 'approve_request_model.g.dart';

@JsonSerializable()
class ApproveRequestModel {
  @JsonKey(name: 'request_id')
  final int requestId;
  @JsonKey(name: 'check_in_new')
  final String checkInNew;
  @JsonKey(name: 'check_out_new')
  final String checkOutNew;

  ApproveRequestModel({
    required this.requestId,
    required this.checkInNew,
    required this.checkOutNew,
  });

  factory ApproveRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ApproveRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveRequestModelToJson(this);
}
