import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Feature/expenses/send_expenses/apis/send_expenses_constants.dart';
import 'package:madarj/Feature/expenses/send_expenses/apis/send_expenses_service.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/create_expense_request.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/request_types_model_response.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/send_exp_categories_model_response.dart';
import 'package:dio/dio.dart';

class SendExpensesRepo {
  SendExpensesRepo(
    this._sendExpensesService,
  );
  final SendExpensesService _sendExpensesService;
  Future<ApiResults<RequestTypesModel>> getRequestTypes() async {
    try {
      final response = await _sendExpensesService.getRequestTypes();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResults<SendExpCategResponse>> getCategories() async {
    try {
      final response = await _sendExpensesService.getCategories();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResults> createExpense(
    CreateExpenseRequest request,
  ) async {
    try {
      final dio = await DioFactory.getDio();

      final options = Options(
        receiveTimeout: const Duration(
          minutes: 1,
        ),
        sendTimeout: const Duration(
          minutes: 1,
        ),
        contentType: "multipart/form-data",
      );

      final response = await dio.post(
        "${ApiConstants.prodBaseDomain}${SendExpensesConstants.createExpense}",
        data: await request.toFormData(),
        options: options,
      );
      print(response.data["success"]);
      return ApiResults.success(response);
    } catch (error) {
      print("error $error");
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }
}
