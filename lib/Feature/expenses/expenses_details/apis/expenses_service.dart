import 'package:dio/dio.dart';
import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/expenses/expenses_details/apis/expenses_constants.dart';
import 'package:madarj/Feature/expenses/expenses_details/data/model/expenses_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'expenses_service.g.dart';

@RestApi(baseUrl: ApiConstants.prodBaseDomain)
abstract class ExpensesService {
  factory ExpensesService(Dio dio, {String baseUrl}) = _ExpensesService;

  @GET(ExpensesConstants.expensesCategories)
  Future getExpenseCategories();

  @GET(ExpensesConstants.newExpenses)
  Future<ExpensesListResponse> getNewExpenses();

  @GET(ExpensesConstants.pendingExpenses)
  Future<ExpensesListResponse> getPendingExpenses();

  @GET(ExpensesConstants.doneExpenses)
  Future<ExpensesListResponse> getDoneExpenses();
}
