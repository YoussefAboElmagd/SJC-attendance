import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Feature/payroll/data/repo/payroll_repo.dart';
import 'package:madarj/Feature/payroll/logic/cubit/payroll_state.dart';

class PayrollCubit extends Cubit<PayrollState> {
  PayrollCubit(this._payrollRepo) : super(const PayrollState.initial());
  final PayrollRepo _payrollRepo;
  Future<void> getEmployeePayslips(
    BuildContext context,
    String? employeeId,
  ) async {
    emit(const PayrollState.getEmployeePayslipsLoading());
    final response = await _payrollRepo.getEmployeePayslips(
      context,
      employeeId,
    );
    response.when(
      success: (payslipResponse) async {
        emit(PayrollState.getEmployeePayslipsSuccess(payslipResponse));
      },
      failure: (apiErrorModel) {
        emit(PayrollState.getEmployeePayslipsError(apiErrorModel));
      },
    );
  }

  Future<void> getPayslipDetails(
    BuildContext context, {
    required String payslipId,
  }) async {
    emit(const PayrollState.getPayslipDetailsLoading());
    final response = await _payrollRepo.getPayslipDetails(
      context,
      payslipId: payslipId,
    );
    response.when(
      success: (payslipDetails) async {
        emit(PayrollState.getPayslipDetailsSuccess(payslipDetails));
      },
      failure: (apiErrorModel) {
        emit(PayrollState.getPayslipDetailsError(apiErrorModel));
      },
    );
  }
}
