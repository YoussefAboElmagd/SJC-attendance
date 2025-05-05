import 'package:madarj/Core/networking/api_constants.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'send_leave_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class SendLeaveService {
  factory SendLeaveService(Dio dio, {String baseUrl}) = _SendLeaveService;
}
