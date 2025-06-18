import 'package:dio/dio.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(
              message:
                  "Connection to server failed due to internet connection");
        case DioExceptionType.cancel:
          return ApiErrorModel(
              message:
                  "Request to the server was cancelled may be due to internet connection");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
              message:
                  "Connection timeout with the server may be due to internet connection");
        case DioExceptionType.unknown:
          return ApiErrorModel(
              message:
                  "Connection to the server failed due to internet connection");
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
              message:
                  "Receive timeout in connection with the server may be due to internet connection");
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
              message:
                  "Send timeout in connection with the server may be due to internet connection");
        default:
          return ApiErrorModel(message: "Something went wrong");
      }
    } else {
      return ApiErrorModel(message: "Unknown error occurred from server");
    }
  }
}

ApiErrorModel _handleError(dynamic data) {
  return ApiErrorModel(
    message: data['message'] ??
        data['error'] ??
        "Unknown error occurred from server",
    code: data['errors'],
    // errors: data['data'],
  );
}
