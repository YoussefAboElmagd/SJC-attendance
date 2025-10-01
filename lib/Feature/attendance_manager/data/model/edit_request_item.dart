import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_request_item.g.dart';

@JsonSerializable()
class GetAllEditRequestsModel {
  final bool? success;
  final int? count;
  @JsonKey(name: 'requests')
  final List<RequestItem>? requestItem;

  GetAllEditRequestsModel({this.success, this.count, this.requestItem});

  factory GetAllEditRequestsModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllEditRequestsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllEditRequestsModelToJson(this);
}
@JsonSerializable()
class RequestItem {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'employee_id')
  final int? employeeId;
  @JsonKey(name: 'attendance_id')
  final int? attendanceId;
  @JsonKey(name: 'employee_name')
  final String? employeeName;
  @JsonKey(name: 'check_in_old')
  final String? checkInOld;
  @JsonKey(name: 'check_out_old')
  final String? checkOutOld;
  @JsonKey(name: 'check_in_new')
  final String? checkInNeW;
  @JsonKey(name: 'check_out_new')
  final String? checkOutNeW;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'created_on')
  final String? createdOn;

  RequestItem({
    this.id,
    this.employeeId,
    this.checkInNeW,
    this.checkOutNeW,
    this.state,
    this.createdOn,
    this.attendanceId,
    this.employeeName,
    this.checkInOld,
    this.checkOutOld,
  });

  factory RequestItem.fromJson(Map<String, dynamic> json) =>
      _$RequestItemFromJson(json);

  Map<String, dynamic> toJson() => _$RequestItemToJson(this);
}
