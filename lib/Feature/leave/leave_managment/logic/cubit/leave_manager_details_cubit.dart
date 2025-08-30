import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Feature/leave/leave_managment/data/model/holiday_summary.dart';
import 'package:madarj/Feature/leave/leave_managment/data/model/new_holiday_response.dart';
import 'package:madarj/Feature/leave/leave_managment/data/repo/leave_manager_details_repo.dart';
import 'package:madarj/Feature/leave/leave_managment/logic/cubit/leave_manager_details_state.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveManagerDetailsCubit extends Cubit<LeaveManagerDetailsState> {
  LeaveManagerDetailsCubit(this._leaveDetailsRepo)
    : super(const LeaveManagerDetailsState.initial());

  final LeaveManagerDetailsRepo _leaveDetailsRepo;

  late HolidaySummaryResponse timeoffBalanceData = HolidaySummaryResponse();
  late NewHolidayResponse requestsApprovedData = NewHolidayResponse();
  late NewHolidayResponse requestsPendingData = NewHolidayResponse();
  late NewHolidayResponse requestsRefusedData = NewHolidayResponse();

  List<HolidayRequestData>? pendingData = [];
  List<HolidayRequestData>? approvedData = [];
  List<HolidayRequestData>? refusedData = [];

  Future<void> getAllLeaves(
    BuildContext context, {
    int pagePending = 1,
    int limitPending = 10,
    int pageRefused = 1,
    int limitRefused = 10,
    int pageApproved = 1,
    int limitApproved = 10,
  }) async {
    emit(const LeaveManagerDetailsState.getAllLeaveLoading());

    try {
      final timeoffBalance = _leaveDetailsRepo.getTimeoffBalance(context);
      final requestsApproved = _leaveDetailsRepo.getRequestsApproved(
        context,
        page: pageApproved,
        limit: limitApproved,
      );
      final requestsPending = _leaveDetailsRepo.getRequestsPending(
        context,
        page: pagePending,
        limit: limitPending,
      );
      final requestsRefused = _leaveDetailsRepo.getRequestsRefused(
        context,
        page: pageRefused,
        limit: limitRefused,
      );

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

      final errors = <ApiErrorModel>[];

      // Helper function to handle errors
      void handleError(ApiErrorModel error, String type) {
        print("$type error: $error");
        errors.add(error);
      }

      timeoffBalanceResult.when(
        success: (_) {},
        failure:
            (error) =>
                handleError(error, 'timeoff Balance Result Result Error'),
      );

      requestsApprovedResult.when(
        success: (_) {},
        failure:
            (error) =>
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
        failure:
            (error) =>
                handleError(error, 'requests Refused Result Result Error'),
      );

      if (errors.isNotEmpty) {
        final uniqueMessages = <String>{};
        for (var error in errors) {
          final msg = error.message ?? S.of(context).Unknown_error;
          uniqueMessages.add(msg);
        }

        final combinedMessage = uniqueMessages.join('\n');

        final combinedError = ApiErrorModel(
          message: combinedMessage,
          status: errors.first.status,
        );

        emit(LeaveManagerDetailsState.getAllLeaveError(combinedError));
        return;
      }

      timeoffBalanceResult.when(
        success: (data) {
          return timeoffBalanceData = data as HolidaySummaryResponse;
        },
        failure: (_) {},
      );

      requestsApprovedResult.when(
        success: (data) {
          requestsApprovedData = data as NewHolidayResponse;
          approvedData!.addAll(requestsApprovedData.data!.data!);
          return requestsApprovedData;
        },
        failure: (_) {},
      );

      requestsPendingResult.when(
        success: (data) {
          requestsPendingData = data as NewHolidayResponse;
          pendingData!.addAll(requestsPendingData.data!.data!);

          return requestsPendingData;
        },
        failure: (_) {},
      );
      requestsRefusedResult.when(
        success: (data) {
          requestsRefusedData = data as NewHolidayResponse;
          refusedData!.addAll(requestsRefusedData.data!.data!);
          return requestsRefusedData;
        },
        failure: (_) {},
      );

      emit(
        LeaveManagerDetailsState.getAllLeaveCombinedSuccess(
          timeoffBalance: timeoffBalanceData,
          requestsApproved: requestsApprovedData,
          requestsPending: requestsPendingData,
          requestsRefused: requestsRefusedData,
        ),
      );
    } catch (e) {
      print("Unexpected error in getAllHome2: $e");
      emit(
        LeaveManagerDetailsState.getAllLeaveError(
          ApiErrorModel(
            message: S.of(context).An_unexpected_error,
            status: '500',
          ),
        ),
      );
    }
  } // Added cancel functionality

  bool hasNextApprove = true;
  bool hasNextRefused = true;
  bool hasNextPending = true;
  int pageApprove = 1;
  int pageRefused = 1;
  int pagePending = 1;

  getPendingTimeoff(BuildContext context, int? pagePending) async {
    emit(const LeaveManagerDetailsState.getPendingLeaveLoading());

    final response = await _leaveDetailsRepo.getRequestsPending(
      context,
      page: pagePending ?? 1,
    );

    response.when(
      success: (data) {
        if (hasNextPending) {
          pendingData!.addAll(data.data!.data!);
          hasNextPending = data.data!.meta!.pagination!.hasNext!;
          this.pagePending++;
        }

        emit(
          LeaveManagerDetailsState.getPendingLeaveSuccess(
            requestsPending: data,
          ),
        );
      },
      failure: (error) {
        emit(LeaveManagerDetailsState.getPendingLeaveError(error));
      },
    );
  }

  getRefusedTimeoff(BuildContext context, int? pageRefused) async {
    emit(const LeaveManagerDetailsState.getRefusedLeaveLoading());

    final response = await _leaveDetailsRepo.getRequestsRefused(
      context,
      page: pageRefused ?? 1,
    );

    response.when(
      success: (data) {
        if (hasNextRefused) {
          refusedData!.addAll(data.data!.data!);
          hasNextRefused = data.data!.meta!.pagination!.hasNext!;
          this.pageRefused++;
        }

        emit(
          LeaveManagerDetailsState.getRefusedLeaveSuccess(
            requestsRefused: data,
          ),
        );
      },
      failure: (error) {
        emit(LeaveManagerDetailsState.getRefusedLeaveError(error));
      },
    );
  }

  getApprovedTimeoff(BuildContext context, int? pageApprove) async {
    emit(const LeaveManagerDetailsState.getApprovedLeaveLoading());

    final response = await _leaveDetailsRepo.getRequestsApproved(
      context,
      page: pageApprove ?? 1,
    );

    response.when(
      success: (data) {
        if (hasNextApprove) {
          approvedData!.addAll(data.data!.data!);
          hasNextApprove = data.data!.meta!.pagination!.hasNext!;
          this.pageApprove++;
        }

        emit(
          LeaveManagerDetailsState.getApprovedLeaveSuccess(
            requestsApproved: data,
          ),
        );
      },
      failure: (error) {
        emit(LeaveManagerDetailsState.getApprovedLeaveError(error));
      },
    );
  }

  Future<void> cancelTimeOff(BuildContext context, int? id) async {
    emit(const LeaveManagerDetailsState.cancelTimeOffLoading());

    try {
      final result = await _leaveDetailsRepo.cancelTimeOff(context, id);

      result.when(
        success: (data) {
          emit(const LeaveManagerDetailsState.cancelTimeOffSuccess());
        },
        failure: (error) {
          print("Cancel timeoff error: $error");
          emit(LeaveManagerDetailsState.cancelTimeOffError(error));
        },
      );
    } catch (e) {
      print("Unexpected error in cancelTimeOff: $e");
      emit(
        LeaveManagerDetailsState.cancelTimeOffError(
          ApiErrorModel(
            message: S.of(context).An_unexpected_error,
            status: '500',
          ),
        ),
      );
    }
  }

  Future<void> approveTimeOff(BuildContext context, int? id) async {
    emit(const LeaveManagerDetailsState.approveTimeOffLoading());

    try {
      print("id in cubit $id");
      final result = await _leaveDetailsRepo.approveTimeOff(context, id);

      result.when(
        success: (data) {
          emit(LeaveManagerDetailsState.approveTimeOffSuccess(data));
        },
        failure: (error) {
          print("Cancel timeoff error: $error");
          emit(LeaveManagerDetailsState.approveTimeOffError(error));
        },
      );
    } catch (e) {
      print("Unexpected error in cancelTimeOff: $e");
      emit(
        LeaveManagerDetailsState.approveTimeOffError(
          ApiErrorModel(
            message: S.of(context).An_unexpected_error,
            status: '500',
          ),
        ),
      );
    }
  }

  Future<void> refuseTimeOff(BuildContext context, int? id) async {
    emit(const LeaveManagerDetailsState.refuseTimeOffLoading());

    try {
      final result = await _leaveDetailsRepo.refuseTimeOff(context, id);

      result.when(
        success: (data) {
          emit(LeaveManagerDetailsState.refuseTimeOffSuccess(data));
        },
        failure: (error) {
          print("Cancel timeoff error: $error");
          emit(LeaveManagerDetailsState.refuseTimeOffError(error));
        },
      );
    } catch (e) {
      print("Unexpected error in cancelTimeOff: $e");
      emit(
        LeaveManagerDetailsState.refuseTimeOffError(
          ApiErrorModel(
            message: S.of(context).An_unexpected_error,
            status: '500',
          ),
        ),
      );
    }
  }

  Future<void> validateTimeOff(BuildContext context, int? id) async {
    emit(const LeaveManagerDetailsState.validateTimeOffLoading());

    try {
      final result = await _leaveDetailsRepo.validateTimeOff(context, id);

      result.when(
        success: (data) {
          emit(LeaveManagerDetailsState.validateTimeOffSuccess(data));
        },
        failure: (error) {
          print("Cancel timeoff error: $error");
          emit(LeaveManagerDetailsState.validateTimeOffError(error));
        },
      );
    } catch (e) {
      print("Unexpected error in cancelTimeOff: $e");
      emit(
        LeaveManagerDetailsState.validateTimeOffError(
          ApiErrorModel(
            message: S.of(context).An_unexpected_error,
            status: '500',
          ),
        ),
      );
    }
  }
}
