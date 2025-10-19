import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Feature/expenses/expenses_details/data/model/expenses_model.dart';
import 'package:madarj/Feature/expenses/expenses_details/data/repo/expenses_repo.dart';
import 'package:madarj/Feature/expenses/expenses_details/logic/cubit/expenses_state.dart';
import 'package:madarj/generated/l10n.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit(this._expensesRepo) : super(const ExpensesState.initial());

  final ExpensesRepo _expensesRepo;

  Future<void> getExpenseCategories(BuildContext context) async {
    emit(const ExpensesState.getExpensesLoading());

    final result = await _expensesRepo.getExpenseCategories(context);

    result.when(
      success: (data) {
        emit(ExpensesState.getExpensesSuccess(data));
      },
      failure: (error) {
        emit(ExpensesState.getExpensesError(error));
      },
    );
  }

  Future<void> getAllExpenses(BuildContext context) async {
    emit(const ExpensesState.getAllExpensesLoading());

    try {
      final newExpenses = _expensesRepo.getNewExpenses(context);
      final pendingExpenses = _expensesRepo.getPendingExpenses(context);
      final doneExpenses = _expensesRepo.getDoneExpenses(context);

      final responses = await Future.wait([
        newExpenses,
        pendingExpenses,
        doneExpenses,
      ]);

      final newExpensesResult = responses[0];
      final pendingExpensesResult = responses[1];
      final doneExpensesResult = responses[2];

      // Collect all errors
      final errors = <ApiErrorModel>[];

      // Helper function to handle errors
      void handleError(ApiErrorModel error, String type) {
        print("$type error: $error");
        errors.add(error);
      }

      newExpensesResult.when(
        success: (_) {},
        failure: (error) => handleError(error, 'new Expenses Result Error'),
      );

      pendingExpensesResult.when(
        success: (_) {},
        failure: (error) => handleError(error, 'pending Expenses Result Error'),
      );

      doneExpensesResult.when(
        success: (_) {},
        failure: (error) => handleError(error, 'done Expenses Result Error'),
      );

      if (errors.isNotEmpty) {
        final uniqueMessages = <String>{};
        for (var error in errors) {
          final msg = error.message ?? S.of(context).Unknown_error;
          uniqueMessages.add(msg);
        }

        final combinedMessage = uniqueMessages.join('\n');

        final combinedError = ApiErrorModel(
          message: combinedMessage,
          status: errors.first.status,
        );

        emit(ExpensesState.getAllExpensesError(combinedError));
        return;
      }

      // Extract successful data with proper types
      late final ExpensesListResponse newExpensesData;
      late final ExpensesListResponse pendingExpensesData;
      late final ExpensesListResponse doneExpensesData;

      newExpensesResult.when(
        success: (data) => newExpensesData = data,
        failure: (_) {},
      );

      pendingExpensesResult.when(
        success: (data) => pendingExpensesData = data,
        failure: (_) {},
      );

      doneExpensesResult.when(
        success: (data) => doneExpensesData = data,
        failure: (_) {},
      );

      emit(
        ExpensesState.getAllExpensesCombinedSuccess(
          newExpenses: newExpensesData,
          pendingExpenses: pendingExpensesData,
          doneExpenses: doneExpensesData,
        ),
      );
    } catch (e) {
      // Handle any unexpected errors
      print("Unexpected error in getAllHome2: $e");
      emit(
        ExpensesState.getAllExpensesError(
          ApiErrorModel(
            message: S.of(context).An_unexpected_error,
            status: '500',
          ),
        ),
      );
    }
  }
}
