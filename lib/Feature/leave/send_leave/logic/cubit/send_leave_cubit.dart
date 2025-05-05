import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:madarj/Feature/leave/send_leave/data/repo/send_leave_repo.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_state.dart';

class SendLeaveCubit extends Cubit<SendLeaveState> {
  SendLeaveCubit(this._sendLeaveRepo) : super(const SendLeaveState.initial());

  final SendLeaveRepo _sendLeaveRepo;

  TextEditingController? leaveCtegory = TextEditingController();
  TextEditingController? leaveDuration = TextEditingController();
  TextEditingController? taskDelegation = TextEditingController();
  TextEditingController? emergencyNumber = TextEditingController();
  TextEditingController? leaveDescription = TextEditingController();

  changeDragDownHint(TextEditingController? controller, String? text) {
    controller!.text = text.toString();
    emit(SendLeaveState.changeDragDownHintSuccess(text));
  }
}
