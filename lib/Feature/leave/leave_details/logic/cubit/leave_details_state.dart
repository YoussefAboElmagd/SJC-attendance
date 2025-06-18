import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';

part 'leave_details_state.freezed.dart';

@freezed
class LeaveDetailsState<T> with _$LeaveDetailsState<T> {
  const factory LeaveDetailsState.initial() = _Initial;

  const factory LeaveDetailsState.getAllLeaveLoading() = GetAllLeaveLoading;

  const factory LeaveDetailsState.getAllLeaveError(ApiErrorModel error) =
      GetAllLeaveError;

  const factory LeaveDetailsState.getAllLeaveCombinedSuccess({
    required T timeoffBalance,
    required T requestsApproved,
    required T requestsPending,
    required T requestsRefused,
  }) = GetAllLeaveCombinedSuccess<T>; // Added cancel states
  const factory LeaveDetailsState.cancelTimeOffLoading() = CancelTimeOffLoading;

  const factory LeaveDetailsState.cancelTimeOffSuccess() = CancelTimeOffSuccess;

  const factory LeaveDetailsState.cancelTimeOffError(ApiErrorModel error) =
      CancelTimeOffError;
}
