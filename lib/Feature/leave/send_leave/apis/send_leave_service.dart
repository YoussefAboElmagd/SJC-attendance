import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/leave/send_leave/apis/send_leave_constants.dart';
import 'package:madarj/Feature/leave/send_leave/data/model/holiday_request_model.dart';
import 'package:madarj/Feature/leave/send_leave/data/model/timeoff_creation_response.dart';
import 'package:madarj/Feature/leave/send_leave/data/model/timeoff_type_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'send_leave_service.g.dart';

@RestApi(baseUrl: ApiConstants.prodBaseDomain)
abstract class SendLeaveService {
  factory SendLeaveService(Dio dio, {String baseUrl}) = _SendLeaveService;

  @POST(SendLeaveConstants.timeoffCreate)
  Future<TimeoffCreationResponse> createTimeoff(
    @Body() HolidayRequestModel request,
  );

  @GET(SendLeaveConstants.timeoffTypes)
  Future<TimeoffTypesResponse> getTimeoffTypes();
}
