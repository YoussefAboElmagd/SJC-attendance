import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';

part 'attendance_manager_state.freezed.dart';

@freezed
class AttendanceManagerState<T> with _$AttendanceManagerState<T> {
  const factory AttendanceManagerState.initial() = _Initial;

  const factory AttendanceManagerState.editRequestLoading() =
      EditRequestLoading;
  const factory AttendanceManagerState.editRequestSuccess(T data) =
      EditRequestSuccess<T>;
  const factory AttendanceManagerState.editRequestError(ApiErrorModel error) =
      EditRequestError;

  const factory AttendanceManagerState.getEditRequestsLoading() =
      GetEditRequestsLoading;
  const factory AttendanceManagerState.getEditRequestsSuccess(T data) =
      GetEditRequestsSuccess<T>;
  const factory AttendanceManagerState.getEditRequestsError(
    ApiErrorModel error,
  ) = GetEditRequestsError;

  const factory AttendanceManagerState.approveRequestLoading() =
      ApproveRequestLoading;
  const factory AttendanceManagerState.approveRequestSuccess(T data) =
      ApproveRequestSuccess<T>;
  const factory AttendanceManagerState.approveRequestError(
    ApiErrorModel error,
  ) = ApproveRequestError;
}
