import 'package:madarj/Core/networking/api_constants.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'send_expenses_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class SendExpensesService {
  factory SendExpensesService(Dio dio, {String baseUrl}) = _SendExpensesService;

}
