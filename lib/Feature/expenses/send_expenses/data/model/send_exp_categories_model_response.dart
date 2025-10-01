// lib/Feature/expenses/send_expenses/data/model/categories_model_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'send_exp_categories_model_response.g.dart';

@JsonSerializable()
class SendExpCategResponse {
  @JsonKey(name: 'categories')
  Map<String, String>? categories;

  SendExpCategResponse({
    this.categories,
  });

  factory SendExpCategResponse.fromJson(Map<String, dynamic> json) =>
      _$SendExpCategResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendExpCategResponseToJson(this);
}