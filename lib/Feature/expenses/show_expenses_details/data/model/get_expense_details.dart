import 'package:json_annotation/json_annotation.dart';

part 'get_expense_details.g.dart';

@JsonSerializable()
class ExpenseDetailsResponse {
  ExpenseDetailsResponse({
    this.data,
  });

  factory ExpenseDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ExpenseDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseDetailsResponseToJson(this);

  @JsonKey(name: 'data')
  ExpenseData? data;
}

@JsonSerializable()
class ExpenseData {
  ExpenseData({
    this.id,
    this.description,
    this.categoryId,
    this.messages,
    this.requestTypeId,
    this.state,
    this.date,
    this.totalAmount,
    this.attachments,
  });

  factory ExpenseData.fromJson(Map<String, dynamic> json) =>
      _$ExpenseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseDataToJson(this);

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'category_id')
  int? categoryId;

  @JsonKey(name: 'category_name')
  String? categoryName;

  @JsonKey(name: 'request_type_id')
  int? requestTypeId;

  @JsonKey(name: 'request_type_name')
  String? requestName;

  @JsonKey(name: 'state')
  String? state;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'total_amount')
  double? totalAmount;

  @JsonKey(name: 'attachments')
  List<Attachment>? attachments;

  @JsonKey(name: 'messages')
  List? messages;
  // "messages": []
}

@JsonSerializable()
class Attachment {
  Attachment({
    this.name,
    this.mimetype,
    this.base64,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'mimetype')
  String? mimetype;

  @JsonKey(name: 'base64')
  String? base64;

  @JsonKey(name: 'extension')
  String? imageExtension;
}