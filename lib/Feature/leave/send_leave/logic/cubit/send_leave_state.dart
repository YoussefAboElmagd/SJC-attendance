import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_leave_state.freezed.dart';

@freezed
class SendLeaveState with _$SendLeaveState {
  const factory SendLeaveState.initial() = _Initial;
  const factory SendLeaveState.changeDragDownHintSuccess(String? text) =
      ChangeDragDownHintSuccess;
}
