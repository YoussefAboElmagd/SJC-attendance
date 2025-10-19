import 'package:flutter/material.dart';
import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/leave/leave_details/apis/leave_details_service.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_request.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_summary.dart';

class LeaveDetailsRepo {
  LeaveDetailsRepo(this._detailsService);
  final LeaveDetailsService _detailsService;

  Future<ApiResults<HolidaySummaryResponse>> getTimeoffBalance(
    BuildContext context,
  ) async {
    try {
      final response = await _detailsService.getTimeoffBalance();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<HolidayRequestResponse>> getRequestsPending(
    BuildContext context,
  ) async {
    try {
      final response = await _detailsService.getRequestsPending();
      return ApiResults.success(response);
    } catch (error) {
      // print(error);
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<HolidayRequestResponse>> getRequestsApproved(
    BuildContext context,
  ) async {
    try {
      final response = await _detailsService.getRequestsApproved();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<HolidayRequestResponse>> getRequestsRefused(
    BuildContext context,
  ) async {
    try {
      final response = await _detailsService.getRequestsRefused();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  } // Added cancel functionality

  Future<ApiResults<dynamic>> cancelTimeOff(
    BuildContext context,
    int? id,
  ) async {
    try {
      final response = await _detailsService.cancelTimeOff({
        "request_id": id ?? 0,
      });
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }
}
