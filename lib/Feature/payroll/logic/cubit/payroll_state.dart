import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';

part 'payroll_state.freezed.dart';

@freezed
class PayrollState<T> with _$PayrollState<T> {
  const factory PayrollState.initial() = _Initial;
  const factory PayrollState.getEmployeePayslipsLoading() =
      GetEmployeePayslipsLoading;
  const factory PayrollState.getEmployeePayslipsSuccess(T data) =
      GetEmployeePayslipsSuccess<T>;
  const factory PayrollState.getEmployeePayslipsError(ApiErrorModel error) =
      GetEmployeePayslipsError;

  const factory PayrollState.getPayslipDetailsLoading() =
      GetPayslipDetailsLoading;
  const factory PayrollState.getPayslipDetailsSuccess(T data) =
      GetPayslipDetailsSuccess<T>;
  const factory PayrollState.getPayslipDetailsError(ApiErrorModel error) =
      GetPayslipDetailsError;
}
