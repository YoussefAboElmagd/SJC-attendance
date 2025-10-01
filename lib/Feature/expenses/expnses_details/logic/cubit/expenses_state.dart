import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';

part 'expenses_state.freezed.dart';

@freezed
class ExpensesState<T> with _$ExpensesState<T> {
  const factory ExpensesState.initial() = _Initial;
  const factory ExpensesState.getExpensesLoading() = GetExpensesLoading;
  const factory ExpensesState.getExpensesSuccess(T data) =
      GetExpensesSuccess<T>;
  const factory ExpensesState.getExpensesError(ApiErrorModel error) =
      GetExpensesError;

  const factory ExpensesState.getAllExpensesLoading() = GetAllExpensesLoading;

  const factory ExpensesState.getAllExpensesError(ApiErrorModel error) =
      GetAllExpensesError;

  const factory ExpensesState.getAllExpensesCombinedSuccess({
    required T newExpenses,
    required T pendingExpenses,
    required T doneExpenses,
  }) = GetAllExpensesCombinedSuccess<T>;
}
