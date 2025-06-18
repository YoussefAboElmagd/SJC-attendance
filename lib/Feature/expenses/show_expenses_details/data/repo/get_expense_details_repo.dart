import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/apis/show_expenses_details_service.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';

class GetExpenseDetailsRepo {
  GetExpenseDetailsRepo(
    this._expensesService,
  );
  final ShowExpensesDetailsService _expensesService;

  Future<ApiResults<ExpenseDetailsResponse>> getExpenseDetails(int? id) async {
    try {
      final response = await _expensesService.getExpenseDetails(id ?? 0);
      return ApiResults.success(response);
    } catch (error) {
      print("error repo $error");
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }
}
