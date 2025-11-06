// -----------------------------------------------------------------------------
// File: api_error_handler.dart
// Edited by: Ahmed Eid Ibrahim
// Changes:
// 2025-10-21: Ahmed Eid Ibrahim – handel error from update occur
// -----------------------------------------------------------------------------

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
  return ApiErrorModel(
    message:
        data['message'] ??
        data['debug'] ??
        data['error'] ??
        S.of(context).Unknown_server_error,
    code: data['errors'],
    errors: data['error'] is Map<String, dynamic> ? data['error'] : null,
    // errors: data['data'],
  );
}
