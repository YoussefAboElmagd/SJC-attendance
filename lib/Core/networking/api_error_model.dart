// api_error_model.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:madarj/Core/helpers/extensions.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  int? code;
  String? message;
  String? status;
  @JsonKey(name: "data")
  final dynamic errors; // Changed to dynamic to handle both Map and List

  ApiErrorModel({this.errors, this.code, this.message, this.status});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  String getAllErrorMessages() {
    // If no errors data, return the message
    if (errors == null) return message ?? "error is unknown";
    
    // Handle case when errors is a List (like in your API response)
    if (errors is List) {
      final errorMessages = <String>[];
      for (var item in errors as List) {
        if (item is Map<String, dynamic>) {
          // Extract error message from each item in the list
          if (item.containsKey('error')) {
            errorMessages.add(item['error'].toString());
          } else if (item.containsKey('message')) {
            errorMessages.add(item['message'].toString());
          }
        } else if (item is String) {
          errorMessages.add(item);
        }
      }
      return errorMessages.isNotEmpty ? errorMessages.join('\n') : (message ?? "error is unknown");
    }
    
    // Handle case when errors is a Map (validation errors)
    if (errors is Map<String, dynamic>) {
      final Map<String, dynamic> errorMap = errors as Map<String, dynamic>;
      if (errorMap.isNotEmpty) {
        final errorMessage = errorMap.entries
            .map((val) {
              var value = val.value;
              if (value is List) {
                return value.join(", ");
              } else {
                return value.toString();
              }
            })
            .join("\n");
        return errorMessage;
      }
    }
    
    // Fallback to message
    return message ?? "error is unknown";
  }
}

// // api_error_model.dart
// import 'package:json_annotation/json_annotation.dart';
// // import 'package:madarj/Core/helpers/extensions.dart';
// part 'api_error_model.g.dart';

// @JsonSerializable()
// class ApiErrorModel {
//   int? code;
//   String? message;
//   String? status;
//   @JsonKey(name: "data")
//   final dynamic errors; // Changed to dynamic to handle both Map and List

//   ApiErrorModel({this.errors, this.code, this.message, this.status});

//   factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
//       _$ApiErrorModelFromJson(json);

//   Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

//   String getAllErrorMessages() {
//     // If no errors data, return the message
//     if (errors == null) return message ?? "error is unknown";
    
//     // Handle case when errors is a List (like in your API response)
//     if (errors is List) {
//       final errorMessages = <String>[];
//       for (var item in errors as List) {
//         if (item is Map<String, dynamic>) {
//           // Extract error message from each item in the list
//           if (item.containsKey('error')) {
//             errorMessages.add(item['error'].toString());
//           } else if (item.containsKey('message')) {
//             errorMessages.add(item['message'].toString());
//           }
//         } else if (item is String) {
//           errorMessages.add(item);
//         }
//       }
//       return errorMessages.isNotEmpty ? errorMessages.join('\n') : (message ?? "error is unknown");
//     }
    
//     // Handle case when errors is a Map (validation errors)
//     if (errors is Map<String, dynamic>) {
//       final Map<String, dynamic> errorMap = errors as Map<String, dynamic>;
//       if (errorMap.isNotEmpty) {
//         final errorMessage = errorMap.entries
//             .map((val) {
//               var value = val.value;
//               if (value is List) {
//                 return value.join(", ");
//               } else {
//                 return value.toString();
//               }
//             })
//             .join("\n");
//         return errorMessage;
//       }
//     }
    
//     // Fallback to message
//     return message ?? "error is unknown";
//   }
// }

// // import 'package:json_annotation/json_annotation.dart';
// // part 'api_error_model.g.dart';

// // @JsonSerializable()

// // class ApiErrorModel {
// //   int? code;
// //   String? message;

// //   ApiErrorModel({this.code, this.message});

// //   factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
// //       _$ApiErrorModelFromJson(json);

// //   Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
// // }
// // import 'package:json_annotation/json_annotation.dart';
// // part 'api_error_model.g.dart';

// // @JsonSerializable()

// // class ApiErrorModel {
// //   int? code;
// //   String? message;

// //   ApiErrorModel({this.code, this.message});

// //   factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
// //       _$ApiErrorModelFromJson(json);

// //   Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
// // }
// import 'package:json_annotation/json_annotation.dart';
// import 'package:madarj/Core/helpers/extensions.dart';
// part 'api_error_model.g.dart';

// @JsonSerializable()
// class ApiErrorModel {
//   int? code;
//   String? message;
//   String? status;
//   @JsonKey(name: "data")
//   final Map<String, dynamic>? errors;

//   ApiErrorModel({this.errors, this.code, this.message, this.status});

//   factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
//       _$ApiErrorModelFromJson(json);

//   Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

//   String getAllErrorMessages() {
//     if (errors.isNotEmptyOrNull()) return message ?? "error is unknown";
//     final errorMessage = errors!.entries
//         .map((val) {
//           var value = val.value;
//           return "${value.join(",")}";
//         })
//         .join("\n");
        
//     return errorMessage;
//   }
// }
