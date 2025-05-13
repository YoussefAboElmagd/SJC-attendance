import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/home/apis/home_constants.dart';
import 'package:madarj/Feature/home/data/model/check_request.dart';
import 'package:madarj/Feature/home/data/model/check_response.dart';
import 'package:madarj/Feature/home/data/model/clock_status_response.dart';
import 'package:madarj/Feature/home/data/model/get_today_work_response.dart';
import 'package:madarj/Feature/home/data/model/pay_period_response.dart';
// import 'package:madarj/Feature/home/data/model/today_At_response.dart';
import 'package:madarj/Feature/home/data/model/total_hours.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'home_services.g.dart';

@RestApi(baseUrl: ApiConstants.prodBaseDomain)
abstract class HomeServices {
  factory HomeServices(Dio dio, {String baseUrl}) = _HomeServices;

  @GET(HomeConstants.todayAtt)
  Future getTodayAtt();

  @GET(HomeConstants.thisPayPeriod)
  Future<PayPeriodResponse> getthisPayPeriod();

  @GET(HomeConstants.totalHours)
  Future<TotalHours> gettotalHours();

  @GET(HomeConstants.todayAtt)
  Future<List<TodayWorkDayEntry>> getTotalTodayWork();
 
  @GET(HomeConstants.clockStatus)
  Future<ClockStatusResponse> getClockStatus();

  @POST(HomeConstants.check)
  Future<AttendanceResponse> checkUser(@Body() CheckRequest checkRequest);
}
