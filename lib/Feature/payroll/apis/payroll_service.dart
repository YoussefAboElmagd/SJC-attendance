import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_details_response.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'payroll_service.g.dart';

@RestApi(baseUrl: ApiConstants.prodBaseDomain)
abstract class PayrollService {
  factory PayrollService(Dio dio, {String baseUrl}) = _PayrollService;

  @GET("employee/total-payslips")
  Future<PayslipResponse> getEmployeePayslips(@Query("employee_id") String? employeeId);
  
  @GET("employee/payslip")
  Future<PayslipDetailsResponse> getPayslipDetails(
    @Query("payslip_id") String payslipId,
    @Query("employee_id") String employeeId,
  );

}