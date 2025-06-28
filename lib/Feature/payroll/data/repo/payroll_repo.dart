import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/payroll/apis/payroll_service.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_details_response.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_response.dart';

class PayrollRepo {
  final PayrollService _payrollService;
  PayrollRepo(this._payrollService);

  Future<ApiResults<PayslipResponse>> getEmployeePayslips(
    String? employeeId,
  ) async {
    try {
      final response = await _payrollService.getEmployeePayslips(employeeId);
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResults<PayslipDetailsResponse>> getPayslipDetails({
    required String payslipId,
    required String employeeId,
  }) async {
    try {
      final response = await _payrollService.getPayslipDetails(
        payslipId,
        employeeId,
      );
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }
}
