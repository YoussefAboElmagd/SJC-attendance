// lib/feature/expenses/send_expenses/data/model/create_expense_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'create_expense_response.g.dart';

@JsonSerializable()
class CreateExpenseResponse {
  final bool? success;
  @JsonKey(name: "record_id")
  final String? recordId;
  @JsonKey(name: "attachment_id")
  final dynamic attachmentId;

  CreateExpenseResponse({this.success, this.attachmentId, this.recordId});

  factory CreateExpenseResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateExpenseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateExpenseResponseToJson(this);
}
