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
}
