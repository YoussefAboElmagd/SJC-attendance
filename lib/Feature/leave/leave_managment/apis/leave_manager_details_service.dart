import 'package:madarj/Core/networking/api_constants.dart';
// import 'package:madarj/Feature/leave/leave_details/apis/leave_details_constants.dart';
// import 'package:madarj/Feature/leave/leave_details/data/model/holiday_request.dart';
// import 'package:madarj/Feature/leave/leave_details/data/model/holiday_summary.dart';
import 'package:madarj/Feature/leave/leave_managment/apis/leave_manager_details_constants.dart';
import 'package:madarj/Feature/leave/leave_managment/data/model/holiday_request.dart';
import 'package:madarj/Feature/leave/leave_managment/data/model/holiday_summary.dart';
import 'package:madarj/Feature/leave/leave_managment/data/model/new_holiday_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'leave_manager_details_service.g.dart';

@RestApi(baseUrl: ApiConstants.prodBaseDomain)
abstract class LeaveManagerDetailsService {
  factory LeaveManagerDetailsService(Dio dio, {String baseUrl}) =
      _LeaveManagerDetailsService;

  @GET(LeaveManagerDetailsConstants.timeoffBalance)
  Future<HolidaySummaryResponse> getTimeoffBalance();

  @GET(LeaveManagerDetailsConstants.requestsPending)
  Future<NewHolidayResponse> getRequestsPending({
    @Query("page") int page = 1,
    @Query("limit") int limit = 10,
  });

  @GET(LeaveManagerDetailsConstants.requestsApproved)
  Future<NewHolidayResponse> getRequestsApproved({
    @Query("page") int page = 1,
    @Query("limit") int limit = 10,
  });

  @GET(LeaveManagerDetailsConstants.requestsRefused)
  Future<NewHolidayResponse> getRequestsRefused({
    @Query("page") int page = 1,
    @Query("limit") int limit = 10,
  });

  @POST(LeaveManagerDetailsConstants.timeoffCancel)
  Future<HolidayRequestResponse> cancelTimeOff(Map<String, int> body);

  @POST(LeaveManagerDetailsConstants.approveTimeoff)
  Future approveTimeOff(Map<String, int> body);

  @POST(LeaveManagerDetailsConstants.refuseTimeoff)
  Future refuseTimeOff(Map<String, int> body);

  @POST(LeaveManagerDetailsConstants.validateTimeoff)
  Future<HolidayRequestResponse> validateTimeOff(Map<String, int> body);
}
