import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Feature/attendance_manager/data/model/edit_request_item.dart';
import 'package:madarj/Feature/attendance_manager/data/repo/attendance_manager_repo.dart';
import 'package:madarj/Feature/attendance_manager/logic/attendance_manager_state.dart';

class AttendanceManagerCubit extends Cubit<AttendanceManagerState> {
  AttendanceManagerCubit(this._attendanceManagerRepo)
    : super(const AttendanceManagerState.initial());

  final AttendanceManagerRepo _attendanceManagerRepo;
  List<RequestItem>? pendingRequestItem = [];
  List<RequestItem>? acceptRequestItem = [];
  List<RequestItem>? refusedRequestItem = [];
  Future<void> getEmployeeEditRequests(BuildContext context) async {
    emit(const AttendanceManagerState.getEditRequestsLoading());
    pendingRequestItem = [];
    acceptRequestItem = [];
    refusedRequestItem = [];
    var response = await _attendanceManagerRepo.getEmployeeEditRequests(
      context,
    );
    response.when(
      success: (data) {
        for (var e in data.requestItem!) {
          print(e.state);
          if (e.state == "pending") {
            pendingRequestItem!.add(e);
          } else if (e.state == "approved") {
            acceptRequestItem!.add(e);
          } else if (e.state == "rejected") {
            refusedRequestItem!.add(e);
          }
        }
        emit(AttendanceManagerState.getEditRequestsSuccess(data));
      },
      failure: (ApiErrorModel apiErrorModel) {
        emit(AttendanceManagerState.getEditRequestsError(apiErrorModel));
      },
    );
  }

  Future<void> getAllEditRequests(BuildContext context) async {
    emit(const AttendanceManagerState.getEditRequestsLoading());

    print("pendingRequestItem1 ${pendingRequestItem}");
    pendingRequestItem = [];
    pendingRequestItem!.clear;
    print("pendingRequestItem2 ${pendingRequestItem}");
    acceptRequestItem = [];
    refusedRequestItem = [];
    var response = await _attendanceManagerRepo.getAllEditRequests(context);
    response.when(
      success: (data) {
        print("pendingRequestItem2 ${pendingRequestItem}");
        print("data ${data.requestItem!}");
        for (var e in data.requestItem!) {
          print(e.state);
          if (e.state == "pending") {
            pendingRequestItem!.add(e);
          } else if (e.state == "approved") {
            acceptRequestItem!.add(e);
          } else if (e.state == "rejected") {
            refusedRequestItem!.add(e);
          }
        }
        // print(pendingRequestItem![0]);
        print(pendingRequestItem);
        emit(AttendanceManagerState.getEditRequestsSuccess(data));
      },
      failure: (ApiErrorModel apiErrorModel) {
        emit(AttendanceManagerState.getEditRequestsError(apiErrorModel));
      },
    );
  }

  Future<void> approveRequest(
    BuildContext context, {
    required int requestId,
    required String checkInNew,
    required String checkOutNew,
  }) async {
    emit(const AttendanceManagerState.approveRequestLoading());
    var response = await _attendanceManagerRepo.approveRequest(
      context,
      requestId: requestId,
      checkInNew: checkInNew,
      checkOutNew: checkOutNew,
    );
    response.when(
      success: (data) {
        emit(AttendanceManagerState.approveRequestSuccess(data));
      },
      failure: (ApiErrorModel apiErrorModel) {
        emit(AttendanceManagerState.approveRequestError(apiErrorModel));
      },
    );
  }
}
