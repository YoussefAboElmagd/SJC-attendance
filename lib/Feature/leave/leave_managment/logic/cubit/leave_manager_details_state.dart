import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Feature/leave/leave_managment/data/model/new_holiday_response.dart';

part 'leave_manager_details_state.freezed.dart';

@freezed
class LeaveManagerDetailsState<T> with _$LeaveManagerDetailsState<T> {
  const factory LeaveManagerDetailsState.initial() = _Initial;

  const factory LeaveManagerDetailsState.getAllLeaveLoading() =
      GetAllLeaveLoading;

  const factory LeaveManagerDetailsState.getAllLeaveError(ApiErrorModel error) =
      GetAllLeaveError;

  const factory LeaveManagerDetailsState.getAllLeaveCombinedSuccess({
    required T timeoffBalance,
    required T requestsApproved,
    required T requestsPending,
    required T requestsRefused,
  }) = GetAllLeaveCombinedSuccess<T>;

  const factory LeaveManagerDetailsState.getPendingLeaveLoading() =
      GetPendingLeaveLoading;

  const factory LeaveManagerDetailsState.getPendingLeaveError(
    ApiErrorModel error,
  ) = GetPendingLeaveError;

  const factory LeaveManagerDetailsState.getPendingLeaveSuccess({
    required T requestsPending,
  }) = GetPendingLeaveSuccess<T>;

  const factory LeaveManagerDetailsState.cancelTimeOffLoading() =
      CancelTimeOffLoading;

  const factory LeaveManagerDetailsState.cancelTimeOffSuccess() =
      CancelTimeOffSuccess;

  const factory LeaveManagerDetailsState.cancelTimeOffError(
    ApiErrorModel error,
  ) = CancelTimeOffError;

  // Add these states to your LeaveManagerDetailsState file

  // For Approved Leave Pagination
  const factory LeaveManagerDetailsState.getApprovedLeaveLoading() =
      GetApprovedLeaveLoading;
  const factory LeaveManagerDetailsState.getApprovedLeaveSuccess({
    required NewHolidayResponse requestsApproved,
  }) = GetApprovedLeaveSuccess;
  const factory LeaveManagerDetailsState.getApprovedLeaveError(
    ApiErrorModel apiErrorModel,
  ) = GetApprovedLeaveError;

  // For Refused Leave Pagination
  const factory LeaveManagerDetailsState.getRefusedLeaveLoading() =
      GetRefusedLeaveLoading;
  const factory LeaveManagerDetailsState.getRefusedLeaveSuccess({
    required NewHolidayResponse requestsRefused,
  }) = GetRefusedLeaveSuccess;
  const factory LeaveManagerDetailsState.getRefusedLeaveError(
    ApiErrorModel apiErrorModel,
  ) = GetRefusedLeaveError;

  // For Approve Time Off Action
  const factory LeaveManagerDetailsState.approveTimeOffLoading() =
      ApproveTimeOffLoading;
  const factory LeaveManagerDetailsState.approveTimeOffSuccess(T data) =
      ApproveTimeOffSuccess;
  const factory LeaveManagerDetailsState.approveTimeOffError(
    ApiErrorModel apiErrorModel,
  ) = ApproveTimeOffError;
  // For Refuse Time Off Action
  const factory LeaveManagerDetailsState.refuseTimeOffLoading() =
      RefuseTimeOffLoading;
  const factory LeaveManagerDetailsState.refuseTimeOffSuccess(T data) =
      RefuseTimeOffSuccess;
  const factory LeaveManagerDetailsState.refuseTimeOffError(
    ApiErrorModel apiErrorModel,
  ) = RefuseTimeOffError;
  // For Validate Time Off Action
  const factory LeaveManagerDetailsState.validateTimeOffLoading() =
      ValidateTimeOffLoading;
  const factory LeaveManagerDetailsState.validateTimeOffSuccess(T data) =
      ValidateTimeOffSuccess;
  const factory LeaveManagerDetailsState.validateTimeOffError(
    ApiErrorModel apiErrorModel,
  ) = ValidateTimeOffError;
}
