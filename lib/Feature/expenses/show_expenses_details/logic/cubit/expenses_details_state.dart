import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
part 'expenses_details_state.freezed.dart';

@freezed
class ExpensesDetailsState<T> with _$ExpensesDetailsState<T> {
  const factory ExpensesDetailsState.initial() = _Initial;
  const factory ExpensesDetailsState.changeImage(T data) = ChangeImage<T>;
  const factory ExpensesDetailsState.getExpenseDetaailsloading() =
      GetExpenseDetaailsLoading;
  const factory ExpensesDetailsState.getExpenseDetaailssuccess(T data) =
      GetExpenseDetaailsSuccess<T>;
  const factory ExpensesDetailsState.getExpenseDetaailserror(ApiErrorModel error) =
      GetExpenseDetaailsError;
}
