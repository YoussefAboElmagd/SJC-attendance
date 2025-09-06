
// api_error_handler.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:madarj/generated/l10n.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(BuildContext context, dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          return ApiErrorModel(message: S.of(context).Connection_failed);
        case DioExceptionType.cancel:
          return ApiErrorModel(message: S.of(context).Request_cancelled);
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: S.of(context).Timeout);
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message: S.of(context).Receive_timeout);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(message: S.of(context).Send_timeout);
        case DioExceptionType.badResponse:
          return _handleError(context, error.response?.data);
        default:
          return ApiErrorModel(message: S.of(context).Something_wrong);
      }
    } else {
      return ApiErrorModel(message: S.of(context).Unknown_server_error);
    }
  }
}

ApiErrorModel _handleError(BuildContext context, dynamic data) {
  if (data == null) {
    return ApiErrorModel(message: S.of(context).Unknown_server_error);
  }

  // Handle the specific API response structure from your logs
  if (data is Map<String, dynamic>) {
    String? message;
    dynamic errors;
    int? code;

    // Try to extract message from different possible keys
    message = data['message']?.toString() ?? 
              data['error']?.toString();

    // Handle the data field which contains the errors
    if (data.containsKey('data') && data['data'] != null) {
      errors = data['data'];
      
      // Extract main message from different data structures
      if (errors is List && errors.isNotEmpty) {
        // Handle case: "data": [{"error": "message"}]
        var firstError = errors.first;
        if (firstError is Map<String, dynamic> && firstError.containsKey('error')) {
          message ??= firstError['error'].toString();
        }
      } else if (errors is Map<String, dynamic>) {
        // Handle case: "data": {"error": "message"}
        if (errors.containsKey('error')) {
          message ??= errors['error'].toString();
        } else if (errors.containsKey('message')) {
          message ??= errors['message'].toString();
        }
      }
    }

    // Handle status codes
    if (data.containsKey('code')) {
      code = data['code'] as int?;
    }

    return ApiErrorModel(
      message: message ?? S.of(context).Unknown_server_error,
      code: code,
      errors: errors,
    );
  }

  // Fallback for non-map responses
  return ApiErrorModel(
    message: data.toString().isNotEmpty ? data.toString() : S.of(context).Unknown_server_error
  );
}
// // api_error_handler.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:madarj/generated/l10n.dart';

// import 'api_error_model.dart';

// class ApiErrorHandler {
//   static ApiErrorModel handle(BuildContext context, dynamic error) {
//     if (error is DioException) {
//       switch (error.type) {
//         case DioExceptionType.connectionError:
//         case DioExceptionType.unknown:
//           return ApiErrorModel(message: S.of(context).Connection_failed);
//         case DioExceptionType.cancel:
//           return ApiErrorModel(message: S.of(context).Request_cancelled);
//         case DioExceptionType.connectionTimeout:
//           return ApiErrorModel(message: S.of(context).Timeout);
//         case DioExceptionType.receiveTimeout:
//           return ApiErrorModel(message: S.of(context).Receive_timeout);
//         case DioExceptionType.sendTimeout:
//           return ApiErrorModel(message: S.of(context).Send_timeout);
//         case DioExceptionType.badResponse:
//           return _handleError(context, error.response?.data);
//         default:
//           return ApiErrorModel(message: S.of(context).Something_wrong);
//       }
//     } else {
//       return ApiErrorModel(message: S.of(context).Unknown_server_error);
//     }
//   }
// }

// ApiErrorModel _handleError(BuildContext context, dynamic data) {
//   if (data == null) {
//     return ApiErrorModel(message: S.of(context).Unknown_server_error);
//   }

//   // Handle the specific API response structure from your log
//   if (data is Map<String, dynamic>) {
//     String? message;
//     dynamic errors;
//     int? code;

//     // Try to extract message from different possible keys
//     message = data['message']?.toString() ?? data['error']?.toString();

//     // Handle the data field which contains the errors
//     if (data.containsKey('data') && data['data'] != null) {
//       errors = data['data'];

//       // If data contains error messages, try to extract a main message
//       if (errors is List && errors.isNotEmpty) {
//         var firstError = errors.first;
//         if (firstError is Map<String, dynamic> &&
//             firstError.containsKey('error')) {
//           message ??= firstError['error'].toString();
//         }
//       }
//     }

//     // Handle status codes
//     if (data.containsKey('code')) {
//       code = data['code'] as int?;
//     }

//     return ApiErrorModel(
//       message: message ?? S.of(context).Unknown_server_error,
//       code: code,
//       errors: errors,
//     );
//   }

//   // Fallback for non-map responses
//   return ApiErrorModel(
//     message:
//         data.toString().isNotEmpty
//             ? data.toString()
//             : S.of(context).Unknown_server_error,
//   );
// }
// // import 'package:dio/dio.dart';
// // import 'package:flutter/material.dart';
// // import 'package:madarj/generated/l10n.dart';

// // import 'api_error_model.dart';

// // class ApiErrorHandler {
// //   static ApiErrorModel handle(BuildContext context, dynamic error) {
// //     if (error is DioException) {
// //       switch (error.type) {
// //         case DioExceptionType.connectionError:
// //         case DioExceptionType.unknown:
// //           return ApiErrorModel(message: S.of(context).Connection_failed);
// //         case DioExceptionType.cancel:
// //           return ApiErrorModel(message: S.of(context).Request_cancelled);
// //         case DioExceptionType.connectionTimeout:
// //           return ApiErrorModel(message: S.of(context).Timeout);
// //         case DioExceptionType.receiveTimeout:
// //           return ApiErrorModel(message: S.of(context).Receive_timeout);
// //         case DioExceptionType.sendTimeout:
// //           return ApiErrorModel(message: S.of(context).Send_timeout);
// //         case DioExceptionType.badResponse:
// //           return _handleError(context, error.response?.data);
// //         default:
// //           return ApiErrorModel(message: S.of(context).Something_wrong);
// //       }
// //     } else {
// //       return ApiErrorModel(message: S.of(context).Unknown_server_error);
// //     }
// //   }
// // }

// // ApiErrorModel _handleError(BuildContext context, dynamic data) {
// //   return ApiErrorModel(
// //     message:
// //         data['message'] ?? data['error'] ?? S.of(context).Unknown_server_error,
// //     code: data['errors'],
// //     errors: data['error'],
// //     // errors: data['data'],
// //   );
// // }
