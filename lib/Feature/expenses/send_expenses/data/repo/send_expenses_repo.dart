import 'package:flutter/material.dart';
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
import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';

class SendExpensesRepo {
  SendExpensesRepo(this._sendExpensesService);
  final SendExpensesService _sendExpensesService;
  Future<ApiResults<RequestTypesModel>> getRequestTypes(
    BuildContext context,
  ) async {
    try {
      final response = await _sendExpensesService.getRequestTypes();
      return ApiResults.success(response);
    } catch (error) {
      print(error);
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<SendExpCategResponse>> getCategories(
    BuildContext context,
  ) async {
    try {
      final response = await _sendExpensesService.getCategories();
      return ApiResults.success(response);
    } catch (error) {
      print(error);
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<ExpenseDetailsResponse>> getExpenseDetails(
    BuildContext context,
    int? id,
  ) async {
    try {
      final response = await _sendExpensesService.getExpenseDetails(id ?? 0);
      return ApiResults.success(response);
    } catch (error) {
      print("error repo $error");
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults> createExpense(
    BuildContext context,
    CreateExpenseRequest request,
  ) async {
    try {
      final dio = await DioFactory.getDio();

      final options = Options(
        receiveTimeout: const Duration(minutes: 1),
        sendTimeout: const Duration(minutes: 1),
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
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults> editExpense(
    BuildContext context,
    int expenseId,
    CreateExpenseRequest request,
  ) async {
    try {
      final dio = await DioFactory.getDio();

      final options = Options(
        receiveTimeout: const Duration(minutes: 1),
        sendTimeout: const Duration(minutes: 1),
        contentType: "multipart/form-data",
      );

      final response = await dio.put(
        "${ApiConstants.prodBaseDomain}${SendExpensesConstants.editExpense}?expense_id=$expenseId",
        data: await request.toFormData(),
        options: options,
      );

      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }
}
