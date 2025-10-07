import 'package:flutter/material.dart';
import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/attendance_manager/apis/attendance_manager_services.dart';
import 'package:madarj/Feature/attendance_manager/data/model/approve_request_model.dart';
import 'package:madarj/Feature/attendance_manager/data/model/approve_request_response.dart';
import 'package:madarj/Feature/attendance_manager/data/model/edit_request_item.dart';

class AttendanceManagerRepo {
  final AttendanceManagerServices _attendanceManagerServices;
  AttendanceManagerRepo(this._attendanceManagerServices);

  Future<ApiResults<GetAllEditRequestsModel>> getEmployeeEditRequests(
    BuildContext context,
  ) async {
    try {
      final response =
          await _attendanceManagerServices.getEmployeeEditRequests();
      return ApiResults.success(response);
    } catch (error) {
      // print("error repo $error");
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<GetAllEditRequestsModel>> getAllEditRequests(
    BuildContext context,
  ) async {
    try {
      final response = await _attendanceManagerServices.getAllEditRequests();
      return ApiResults.success(response);
    } catch (error) {
      // print("error repo $error");
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults> approveRequest(
    BuildContext context, {
    required int requestId,
    required String checkInNew,
    required String checkOutNew,
  }) async {
    try {
      final request = ApproveRequestModel(
        requestId: requestId,
        checkInNew: checkInNew,
        checkOutNew: checkOutNew,
      );
      final response = await _attendanceManagerServices.approveRequest(request);
      return ApiResults.success(response);
    } catch (error) {
      // print("error repo $error");
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }
}
