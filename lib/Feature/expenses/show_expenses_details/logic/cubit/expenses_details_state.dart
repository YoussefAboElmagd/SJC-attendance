
import 'package:freezed_annotation/freezed_annotation.dart';
part 'expenses_details_state.freezed.dart';

@freezed
class ExpensesDetailsState<T> with _$ExpensesDetailsState<T> {
  const factory ExpensesDetailsState.initial() = _Initial;
    const factory ExpensesDetailsState.changeImage(T data) = ChangeImage<T>;

}
