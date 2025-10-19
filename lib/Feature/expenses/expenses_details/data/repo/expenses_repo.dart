import 'package:flutter/material.dart';
import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/expenses/expenses_details/apis/expenses_service.dart';
import 'package:madarj/Feature/expenses/expenses_details/data/model/expenses_model.dart';

class ExpensesRepo {
  ExpensesRepo(this._expensesService);
  final ExpensesService _expensesService;

  Future getExpenseCategories(BuildContext context) async {
    try {
      final response = await _expensesService.getExpenseCategories();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<ExpensesListResponse>> getNewExpenses(
    BuildContext context,
  ) async {
    try {
      final response = await _expensesService.getNewExpenses();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<ExpensesListResponse>> getPendingExpenses(
    BuildContext context,
  ) async {
    try {
      final response = await _expensesService.getPendingExpenses();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<ExpensesListResponse>> getDoneExpenses(
    BuildContext context,
  ) async {
    try {
      final response = await _expensesService.getDoneExpenses();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }
}
