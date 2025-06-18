import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_request.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_summary.dart';
import 'package:madarj/Feature/leave/leave_details/data/repo/leave_details_repo.dart';
import 'package:madarj/Feature/leave/leave_details/logic/cubit/leave_details_state.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveDetailsCubit extends Cubit<LeaveDetailsState> {
  LeaveDetailsCubit(this._leaveDetailsRepo)
    : super(const LeaveDetailsState.initial());

  final LeaveDetailsRepo _leaveDetailsRepo;

  Future<void> getAllLeaves(BuildContext context) async {
    emit(const LeaveDetailsState.getAllLeaveLoading());

    try {
      final timeoffBalance = _leaveDetailsRepo.getTimeoffBalance();
      final requestsApproved = _leaveDetailsRepo.getRequestsApproved();
      final requestsPending = _leaveDetailsRepo.getRequestsPending();
      final requestsRefused = _leaveDetailsRepo.getRequestsRefused();

      final responses = await Future.wait([
        timeoffBalance,
        requestsApproved,
        requestsPending,
        requestsRefused,
      ]);

      final timeoffBalanceResult = responses[0];
      final requestsApprovedResult = responses[1];
      final requestsPendingResult = responses[2];
      final requestsRefusedResult = responses[3];

      // Collect all errors
      final errors = <ApiErrorModel>[];

      // Helper function to handle errors
      void handleError(ApiErrorModel error, String type) {
        print("$type error: $error");
        errors.add(error);
      }

      timeoffBalanceResult.when(
        success: (_) {},
        failure: (error) =>
            handleError(error, 'timeoff Balance Result Result Error'),
      );

      requestsApprovedResult.when(
        success: (_) {},
        failure: (error) =>
            handleError(error, 'requests Approved Result Result Error'),
      );

      requestsPendingResult.when(
        success: (_) {},
        failure: (error) {
          print(error);
          handleError(error, 'requests Pending Result Result Error');
        },
      );
      requestsRefusedResult.when(
        success: (_) {},
        failure: (error) =>
            handleError(error, 'requests Refused Result Result Error'),
      );

      if (errors.isNotEmpty) {
        final uniqueMessages = <String>{};
        for (var error in errors) {
          final msg = error.message ?? 'Unknown error';
          uniqueMessages.add(msg);
        }

        final combinedMessage = uniqueMessages.join('\n');

        final combinedError = ApiErrorModel(
          message: combinedMessage,
          status: errors.first.status,
        );

        emit(LeaveDetailsState.getAllLeaveError(combinedError));
        return;
      }

      // Extract successful data with proper types
      late final HolidaySummaryResponse timeoffBalanceData;
      late final HolidayRequestResponse requestsApprovedData;
      late final HolidayRequestResponse requestsPendingData;
      late final HolidayRequestResponse requestsRefusedData;

      timeoffBalanceResult.when(
        success: (data) => timeoffBalanceData = data as HolidaySummaryResponse,
        failure: (_) {},
      );

      requestsApprovedResult.when(
        success: (data) =>
            requestsApprovedData = data as HolidayRequestResponse,
        failure: (_) {},
      );

      requestsPendingResult.when(
        success: (data) => requestsPendingData = data as HolidayRequestResponse,
        failure: (_) {},
      );
      requestsRefusedResult.when(
        success: (data) => requestsRefusedData = data as HolidayRequestResponse,
        failure: (_) {},
      );

      emit(
        LeaveDetailsState.getAllLeaveCombinedSuccess(
          timeoffBalance: timeoffBalanceData,
          requestsApproved: requestsApprovedData,
          requestsPending: requestsPendingData,
          requestsRefused: requestsRefusedData,
        ),
      );
    } catch (e) {
      // Handle any unexpected errors
      print("Unexpected error in getAllHome2: $e");
      emit(
        LeaveDetailsState.getAllLeaveError(
          ApiErrorModel(
            message: S.of(context).An_unexpected_error,
            status: '500',
          ),
        ),
      );
    }
  } // Added cancel functionality

  Future<void> cancelTimeOff(
    BuildContext context,
    int? id,
  ) async {
    emit(const LeaveDetailsState.cancelTimeOffLoading());

    try {
      final result = await _leaveDetailsRepo.cancelTimeOff(id);

      result.when(
        success: (data) {
          emit(const LeaveDetailsState.cancelTimeOffSuccess());
        },
        failure: (error) {
          print("Cancel timeoff error: $error");
          emit(LeaveDetailsState.cancelTimeOffError(error));
        },
      );
    } catch (e) {
      print("Unexpected error in cancelTimeOff: $e");
      emit(
        LeaveDetailsState.cancelTimeOffError(
          ApiErrorModel(
            message: S.of(context).An_unexpected_error,
            status: '500',
          ),
        ),
      );
    }
  }
}
