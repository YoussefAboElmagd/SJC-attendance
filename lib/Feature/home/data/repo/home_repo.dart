import 'package:flutter/material.dart';
import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/home/apis/home_services.dart';
import 'package:madarj/Feature/home/data/model/attendance_edit_request.dart';
import 'package:madarj/Feature/home/data/model/attendance_edit_response.dart';
import 'package:madarj/Feature/home/data/model/check_request.dart';
import 'package:madarj/Feature/home/data/model/check_response.dart';
import 'package:madarj/Feature/home/data/model/clock_status_response.dart';
import 'package:madarj/Feature/attendance_manager/data/model/edit_request_item.dart';
import 'package:madarj/Feature/home/data/model/get_today_work_response.dart';
import 'package:madarj/Feature/home/data/model/notification_request.dart';
import 'package:madarj/Feature/home/data/model/pay_period_response.dart';
import 'package:madarj/Feature/home/data/model/total_hours.dart';

class HomeRepo {
  final HomeServices _homeServices;
  HomeRepo(this._homeServices);

  // Future<ApiResults> getTodayAtt() async {
  //   try {
  //     final response = await _homeServices.getTodayAtt();
  //     return ApiResults.success(response);
  //   } catch (error) {
  //     return ApiResults.failure(ApiErrorHandler.handle(context,error));
  //   }
  // }
  Future<ApiResults<PayPeriodResponse>> getthisPayPeriod(
    BuildContext context,
  ) async {
    try {
      final response = await _homeServices.getthisPayPeriod();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<TotalHours>> gettotalHours(BuildContext context) async {
    try {
      final response = await _homeServices.gettotalHours();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<AttendanceResponse>> checkUser(
    BuildContext context,
    CheckRequest checkRequest,
  ) async {
    try {
      final response = await _homeServices.checkUser(checkRequest);
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<List<TodayWorkDayEntry>>> getTotalTodayWork(
    BuildContext context,
  ) async {
    try {
      final response = await _homeServices.getTotalTodayWork();
      return ApiResults.success(response);
    } catch (error) {
      // print("error repo $error");
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<ClockStatusResponse>> getAttendanceState(
    BuildContext context,
  ) async {
    try {
      final response = await _homeServices.getClockStatus();
      return ApiResults.success(response);
    } catch (error) {
      // print("error repo $error");
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<ClockStatusResponse>> snedToken(
    BuildContext context,
    NotificationRequest notificationRequest,
  ) async {
    try {
      final response = await _homeServices.sendFcmToken(notificationRequest);
      return ApiResults.success(response);
    } catch (error) {
      // print("error repo $error");
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  } // NEW: Add these methods

  Future<ApiResults<AttendanceEditResponse>> createEditRequest(
    BuildContext context,
    int attendanceId,
  ) async {
    try {
      final request = AttendanceEditRequest(attendanceId: attendanceId);
      final response = await _homeServices.createEditRequest(request);
      return ApiResults.success(response);
    } catch (error) {
      // print("error repo $error");
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }
}
