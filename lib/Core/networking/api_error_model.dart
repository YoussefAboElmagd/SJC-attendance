// import 'package:json_annotation/json_annotation.dart';
// part 'api_error_model.g.dart';

// @JsonSerializable()

// class ApiErrorModel {
//   int? code;
//   String? message;

//   ApiErrorModel({this.code, this.message});

//   factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
//       _$ApiErrorModelFromJson(json);

//   Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
// }
// import 'package:json_annotation/json_annotation.dart';
// part 'api_error_model.g.dart';

// @JsonSerializable()

// class ApiErrorModel {
//   int? code;
//   String? message;

//   ApiErrorModel({this.code, this.message});

//   factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
//       _$ApiErrorModelFromJson(json);

//   Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
// }
import 'package:json_annotation/json_annotation.dart';
import 'package:madarj/Core/helpers/extensions.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  int? code;
  String? message;
  String? status;
  @JsonKey(name: "data")
  final Map<String, dynamic>? errors;

  ApiErrorModel({this.errors, this.code, this.message, this.status});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  String getAllErrorMessages() {
    if (errors.isNotEmptyOrNull()) return message ?? "error is unknown";
    final errorMessage = errors!.entries.map((val) {
      var value = val.value;
      return "${value.join(",")}";
    }).join("\n");
    return errorMessage;
  }
}
