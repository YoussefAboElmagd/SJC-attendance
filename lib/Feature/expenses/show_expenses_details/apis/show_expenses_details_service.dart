import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/apis/show_expenses_details_constants.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';
import 'package:retrofit/error_logger.dart';
// import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'show_expenses_details_service.g.dart';

@RestApi(baseUrl: ApiConstants.prodBaseDomain)
abstract class ShowExpensesDetailsService {
  factory ShowExpensesDetailsService(Dio dio, {String baseUrl}) =
      _ShowExpensesDetailsService;
  @GET(ShowExpensesDetailsConstants.doneExpenses)
  Future<ExpenseDetailsResponse> getExpenseDetails(
    @Query("expense_id") int expenseId, // No toJson() needed for primitives
  );
}
