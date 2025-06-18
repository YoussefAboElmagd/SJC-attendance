import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/leave/send_leave/apis/send_leave_service.dart';
import 'package:madarj/Feature/leave/send_leave/data/model/holiday_request_model.dart';
import 'package:madarj/Feature/leave/send_leave/data/model/timeoff_creation_response.dart';
import 'package:madarj/Feature/leave/send_leave/data/model/timeoff_type_model.dart';

class SendLeaveRepo {
  SendLeaveRepo(this._sendLeaveService);
  final SendLeaveService _sendLeaveService;

  Future<ApiResults<TimeoffCreationResponse>> createTimeoff(
    HolidayRequestModel request,
  ) async {
    try {
      final response = await _sendLeaveService.createTimeoff(request);
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResults<TimeoffTypesResponse>> getTimeoffTypes() async {
    try {
      final response = await _sendLeaveService.getTimeoffTypes();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }
}
