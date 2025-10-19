import 'package:json_annotation/json_annotation.dart';

part 'expenses_model.g.dart';

@JsonSerializable()
class ExpensesListResponse {
  @JsonKey(name: 'results')
  int? results;

  @JsonKey(name: 'data')
  List<ExpenseData>? data;

  ExpensesListResponse({
    this.results,
    this.data,
  });

  factory ExpensesListResponse.fromJson(Map<String, dynamic> json) =>
      _$ExpensesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesListResponseToJson(this);
}

@JsonSerializable()
class ExpenseData {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'state')
  String? status;

  @JsonKey(name: 'total_amount')
  double? totalAmount;

  ExpenseData({
    this.name,
    this.date,
    this.totalAmount,
  });

  factory ExpenseData.fromJson(Map<String, dynamic> json) =>
      _$ExpenseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseDataToJson(this);
}
