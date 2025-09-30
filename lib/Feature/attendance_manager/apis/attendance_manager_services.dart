import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/attendance_manager/apis/attendance_manager_constants.dart';
import 'package:madarj/Feature/attendance_manager/data/model/approve_request_model.dart';
import 'package:madarj/Feature/attendance_manager/data/model/approve_request_response.dart';
import 'package:madarj/Feature/attendance_manager/data/model/edit_request_item.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'attendance_manager_services.g.dart';

@RestApi(baseUrl: ApiConstants.prodBaseDomain)
abstract class AttendanceManagerServices {
  factory AttendanceManagerServices(Dio dio, {String baseUrl}) =
      _AttendanceManagerServices;

  @GET(AttendanceManagerConstants.getRequests)
  Future<GetAllEditRequestsModel> getEmployeeEditRequests();

  @GET(AttendanceManagerConstants.getAllRequests)
  Future<GetAllEditRequestsModel> getAllEditRequests();
  
  @POST(AttendanceManagerConstants.approveRequest)
  Future approveRequest(
    @Body() ApproveRequestModel request,
  );
}
