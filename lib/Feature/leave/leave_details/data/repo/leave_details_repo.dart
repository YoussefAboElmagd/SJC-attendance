import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/leave/leave_details/apis/leave_details_service.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_request.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_summary.dart';

class LeaveDetailsRepo {
  LeaveDetailsRepo(this._detailsService);
  final LeaveDetailsService _detailsService;

  Future<ApiResults<HolidaySummaryResponse>> getTimeoffBalance() async {
    try {
      final response = await _detailsService.getTimeoffBalance();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResults<HolidayRequestResponse>> getRequestsPending() async {
    try {
      final response = await _detailsService.getRequestsPending();
      return ApiResults.success(response);
    } catch (error) {
      print(error);
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResults<HolidayRequestResponse>> getRequestsApproved() async {
    try {
      final response = await _detailsService.getRequestsApproved();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResults<HolidayRequestResponse>> getRequestsRefused() async {
    try {
      final response = await _detailsService.getRequestsRefused();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  } // Added cancel functionality

  Future<ApiResults<dynamic>> cancelTimeOff(int? id) async {
    try {
      final response = await _detailsService.cancelTimeOff({
        "request_id": id ?? 0,
      });
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }
}
