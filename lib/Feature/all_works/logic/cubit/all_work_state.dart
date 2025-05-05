import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';

part 'all_work_state.freezed.dart';

@freezed
class AllWorkState<T> with _$AllWorkState<T> {
  const factory AllWorkState.initial() = _Initial;

  const factory AllWorkState.getAllUserMonthWorkLoading() =
      GetAllUserMonthWorkLoading;
  const factory AllWorkState.getAllUserMonthWorkSuccess(T data) =
      GetAllUserMonthWorkSuccess<T>;
  const factory AllWorkState.getAllUserMonthWorkError(ApiErrorModel error) =
      GetAllUserMonthWorkError;
}
