import 'package:flutter/material.dart';
import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
// import 'package:madarj/Feature/leave/leave_details/data/model/holiday_request.dart';
// import 'package:madarj/Feature/leave/leave_details/data/model/holiday_summary.dart';
import 'package:madarj/Feature/leave/leave_managment/apis/leave_manager_details_service.dart';
// import 'package:madarj/Feature/leave/leave_managment/data/model/holiday_request.dart';
import 'package:madarj/Feature/leave/leave_managment/data/model/holiday_summary.dart';
import 'package:madarj/Feature/leave/leave_managment/data/model/new_holiday_response.dart';

class LeaveManagerDetailsRepo {
  LeaveManagerDetailsRepo(this._managerService);
  final LeaveManagerDetailsService _managerService;

  Future<ApiResults<HolidaySummaryResponse>> getTimeoffBalance(
    BuildContext context,
  ) async {
    try {
      final response = await _managerService.getTimeoffBalance();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<NewHolidayResponse>> getRequestsPending(
    BuildContext context, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _managerService.getRequestsPending(
        page: page,
        limit: limit,
      );
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<NewHolidayResponse>> getRequestsApproved(
    BuildContext context, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _managerService.getRequestsApproved(
        page: page,
        limit: limit,
      );
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<NewHolidayResponse>> getRequestsRefused(
    BuildContext context, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _managerService.getRequestsRefused(
        page: page,
        limit: limit,
      );
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<dynamic>> cancelTimeOff(
    BuildContext context,
    int? id,
  ) async {
    try {
      print("id in repo $id");

      final response = await _managerService.cancelTimeOff({
        "request_id": id ?? 0,
      });
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<dynamic>> approveTimeOff(
    BuildContext context,
    int? id,
  ) async {
    try {
      print("id in repo $id");
      final response = await _managerService.approveTimeOff({
        "request_id": id ?? 0,
      });
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<dynamic>> refuseTimeOff(
    BuildContext context,
    int? id,
  ) async {
    try {
      print("id in repo $id");

      final response = await _managerService.refuseTimeOff({
        "request_id": id ?? 0,
      });
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<dynamic>> validateTimeOff(
    BuildContext context,
    int? id,
  ) async {
    try {
      final response = await _managerService.validateTimeOff({
        "request_id": id ?? 0,
      });
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }
}
