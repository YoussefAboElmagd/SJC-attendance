import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Feature/leave/send_leave/data/model/holiday_request_model.dart';
import 'package:madarj/Feature/leave/send_leave/data/repo/send_leave_repo.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_state.dart';

class SendLeaveCubit extends Cubit<SendLeaveState> {
  SendLeaveCubit(this._sendLeaveRepo) : super(const SendLeaveState.initial());

  final SendLeaveRepo _sendLeaveRepo;
  String? selectedItem;
  DateTime? startDate;
  DateTime? endDate;
  TextEditingController? leaveCtegory = TextEditingController();
  TextEditingController? leaveCtegoryId = TextEditingController();
  TextEditingController? leaveDuration = TextEditingController();
  TextEditingController? taskDelegation = TextEditingController();
  TextEditingController? emergencyNumber = TextEditingController();
  TextEditingController? leaveDescription = TextEditingController();

  changeDragDownHint(TextEditingController? controller, String? text) {
    controller!.text = text.toString();
    selectedItem = text.toString();
    emit(SendLeaveState.changeDragDownHintSuccess(text));
  }

  Future<void> submitLeaveRequest(
    BuildContext context,
    HolidayRequestModel request,
  ) async {
    emit(const SendLeaveState.submitLeaveRequestLoading());

    try {
      final result = await _sendLeaveRepo.createTimeoff(context, request);

      result.when(
        success: (response) {
          emit(SendLeaveState.submitLeaveRequestSuccess(response));
        },
        failure: (error) {
          emit(SendLeaveState.submitLeaveRequestError(error));
        },
      );
    } catch (e) {
      emit(
        SendLeaveState.submitLeaveRequestError(
          ApiErrorModel(message: e.toString()),
        ),
      );
    }
  }

  Future<void> getTimeOffTypes(BuildContext context) async {
    emit(const SendLeaveState.timeoffTypesLoading());

    try {
      final result = await _sendLeaveRepo.getTimeoffTypes(context);

      result.when(
        success: (response) {
          emit(SendLeaveState.timeoffTypesSuccess(response));
        },
        failure: (error) {
          emit(SendLeaveState.timeoffTypesError(error));
        },
      );
    } catch (e) {
      emit(
        SendLeaveState.timeoffTypesError(ApiErrorModel(message: e.toString())),
      );
    }
  }
}
