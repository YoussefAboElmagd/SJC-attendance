import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/home/apis/home_services.dart';
import 'package:madarj/Feature/home/data/model/check_request.dart';
import 'package:madarj/Feature/home/data/model/check_response.dart';
import 'package:madarj/Feature/home/data/model/clock_status_response.dart';
import 'package:madarj/Feature/home/data/model/get_today_work_response.dart';
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
  //     return ApiResults.failure(ApiErrorHandler.handle(error));
  //   }
  // }
  Future<ApiResults<PayPeriodResponse>> getthisPayPeriod() async {
    try {
      final response = await _homeServices.getthisPayPeriod();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResults<TotalHours>> gettotalHours() async {
    try {
      final response = await _homeServices.gettotalHours();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResults<AttendanceResponse>> checkUser(
      CheckRequest checkRequest) async {
    try {
      final response = await _homeServices.checkUser(checkRequest);
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResults<List<TodayWorkDayEntry>>> getTotalTodayWork() async {
    try {
      final response = await _homeServices.getTotalTodayWork();
      return ApiResults.success(response);
    } catch (error) {
      print("error repo $error");
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResults<ClockStatusResponse>> getAttendanceState() async {
    try {
      final response = await _homeServices.getClockStatus();
      return ApiResults.success(response);
    } catch (error) {
      print("error repo $error");
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }
}
