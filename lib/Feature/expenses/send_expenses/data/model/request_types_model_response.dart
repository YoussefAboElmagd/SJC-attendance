// lib/Feature/expenses/send_expenses/model/request_types_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'request_types_model_response.g.dart';

@JsonSerializable()
class RequestTypesModel {
  @JsonKey(name: 'request_types')
  Map<String, String>? requestTypes;

  RequestTypesModel({
    this.requestTypes,
  });

  factory RequestTypesModel.fromJson(Map<String, dynamic> json) =>
      _$RequestTypesModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestTypesModelToJson(this);
}