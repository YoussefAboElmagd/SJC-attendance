import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/expenses/expnses_details/apis/expenses_service.dart';
import 'package:madarj/Feature/expenses/send_expenses/apis/send_expenses_service.dart';

class ExpensesRepo {
  ExpensesRepo(
    this._expensesService,
  );
  final ExpensesService _expensesService;

  Future getExpenseCategories() async {
    try {
      final response = await _expensesService.getExpenseCategories();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }
}
