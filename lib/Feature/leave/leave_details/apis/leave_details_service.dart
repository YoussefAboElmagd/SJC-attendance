import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/leave/leave_details/apis/leave_details_constants.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_request.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_summary.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'leave_details_service.g.dart';

@RestApi(baseUrl: ApiConstants.prodBaseDomain)
abstract class LeaveDetailsService {
  factory LeaveDetailsService(Dio dio, {String baseUrl}) = _LeaveDetailsService;

  @GET(LeaveDetailsConstants.timeoffBalance)
  Future<HolidaySummaryResponse> getTimeoffBalance();

  @GET(LeaveDetailsConstants.requestsPending)
  Future<HolidayRequestResponse> getRequestsPending();

  @GET(LeaveDetailsConstants.requestsApproved)
  Future<HolidayRequestResponse> getRequestsApproved();

  @GET(LeaveDetailsConstants.requestsRefused)
  Future<HolidayRequestResponse> getRequestsRefused();

  @POST(LeaveDetailsConstants.timeoffCancel)
  Future<HolidayRequestResponse> cancelTimeOff(Map<String,int>body);
}
