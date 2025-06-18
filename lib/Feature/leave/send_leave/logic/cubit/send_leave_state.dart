import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';

part 'send_leave_state.freezed.dart';

@freezed
class SendLeaveState<T> with _$SendLeaveState<T> {
  const factory SendLeaveState.initial() = _Initial;
  const factory SendLeaveState.changeDragDownHintSuccess(String? text) =
      ChangeDragDownHintSuccess;
  const factory SendLeaveState.submitLeaveRequestLoading() =
      SubmitLeaveRequestLoading;
  const factory SendLeaveState.submitLeaveRequestSuccess(T data) =
      SubmitLeaveRequestSuccess<T>;
  const factory SendLeaveState.submitLeaveRequestError(ApiErrorModel error) =
      SubmitLeaveRequestError; // Add these new states
  const factory SendLeaveState.timeoffTypesLoading() = TimeoffTypesLoading;
  const factory SendLeaveState.timeoffTypesSuccess(T data) =
      TimeoffTypesSuccess;
  const factory SendLeaveState.timeoffTypesError(ApiErrorModel error) =
      TimeoffTypesError;
}
