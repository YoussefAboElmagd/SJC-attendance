// timeoff_type_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'timeoff_type_model.g.dart';

@JsonSerializable()
class TimeoffTypesResponse {
  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'data')
  List<TimeoffTypeModel>? data;

  TimeoffTypesResponse({this.count, this.data});

  factory TimeoffTypesResponse.fromJson(Map<String, dynamic> json) =>
      _$TimeoffTypesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TimeoffTypesResponseToJson(this);
}

@JsonSerializable()
class TimeoffTypeModel {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'color')
  String? color;

  @JsonKey(name: 'requires_allocation')
  String? requiresAllocation;

  @JsonKey(name: 'active')
  bool? active;

  TimeoffTypeModel({
    this.id,
    this.name,
    this.color,
    this.requiresAllocation,
    this.active,
  });

  factory TimeoffTypeModel.fromJson(Map<String, dynamic> json) =>
      _$TimeoffTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeoffTypeModelToJson(this);
}
