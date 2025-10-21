// -----------------------------------------------------------------------------
// File: home_services.dart
// Description: Home services class
// Edited by: Ahmed Eid Ibrahim
// changelog:
// 2025-10-21: Ahmed Eid Ibrahim – add service for update attendance when admin use app.
// -----------------------------------------------------------------------------

import 'package:dio/dio.dart';
import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/home/apis/home_constants.dart';
import 'package:madarj/Feature/home/data/model/attendance_edit_manager_request.dart';
import 'package:madarj/Feature/home/data/model/attendance_edit_manager_response.dart';
import 'package:madarj/Feature/home/data/model/attendance_edit_request.dart';
import 'package:madarj/Feature/home/data/model/attendance_edit_response.dart';
import 'package:madarj/Feature/home/data/model/check_request.dart';
import 'package:madarj/Feature/home/data/model/check_response.dart';
import 'package:madarj/Feature/home/data/model/clock_status_response.dart';
import 'package:madarj/Feature/home/data/model/get_today_work_response.dart';
import 'package:madarj/Feature/home/data/model/notification_request.dart';
import 'package:madarj/Feature/home/data/model/pay_period_response.dart';
// import 'package:madarj/Feature/home/data/model/today_At_response.dart';
import 'package:madarj/Feature/home/data/model/total_hours.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

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

  @POST(HomeConstants.tokenNotification)
  Future sendFcmToken(@Body() NotificationRequest notificationRequest);

  @POST(HomeConstants.editAttendance)
  Future<AttendanceEditResponse> createEditRequest(
    @Body() AttendanceEditRequest request,
  );

  /// update attendance when admin use app
  @POST(HomeConstants.updateManagerAttendance)
  Future<AttendanceEditManagerResponse> attendanceEditManager(
    @Body() AttendanceEditManagerRequest request,
  );
}
