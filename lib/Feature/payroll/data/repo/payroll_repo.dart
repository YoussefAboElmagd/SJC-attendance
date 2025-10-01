import 'package:flutter/material.dart';
import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/payroll/apis/payroll_service.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_details_response.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_response.dart';

class PayrollRepo {
  final PayrollService _payrollService;
  PayrollRepo(this._payrollService);

  Future<ApiResults<PayslipResponse>> getEmployeePayslips(
    BuildContext context,
    String? employeeId,
  ) async {
    try {
      final response = await _payrollService.getEmployeePayslips(employeeId);
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }

  Future<ApiResults<PayslipDetailsResponse>> getPayslipDetails(
    BuildContext context, {
    required String payslipId,
  }) async {
    try {
      final response = await _payrollService.getPayslipDetails(payslipId);
      return ApiResults.success(response);
    } catch (error) {
      print(error);
      return ApiResults.failure(ApiErrorHandler.handle(context, error));
    }
  }
}
