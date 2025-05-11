import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/expenses/expnses_details/apis/expenses_constants.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'expenses_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ExpensesService {
  factory ExpensesService(Dio dio, {String baseUrl}) = _ExpensesService;

  @GET(ExpensesConstants.expensesCategories)
  Future getExpenseCategories(); 
}
