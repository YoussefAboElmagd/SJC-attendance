import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Feature/payroll/logic/cubit/payroll_cubit.dart';
import 'package:madarj/Feature/payroll/logic/cubit/payroll_state.dart';
import 'package:madarj/Feature/payroll/ui/widget/payroll_error_handler.dart';
import 'package:madarj/Feature/payroll/ui/widget/payroll_loading.dart';



class PayrollDetailsBody extends StatelessWidget {
  const PayrollDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayrollCubit, PayrollState>(
      buildWhen: (previous, current) =>
          current is GetPayslipDetailsLoading ||
          current is GetPayslipDetailsError ||
          current is GetPayslipDetailsSuccess,
      builder: (context, state) {
        return state.maybeWhen(
          getPayslipDetailsLoading: () => const PayrollLoadingWidget(),
          getPayslipDetailsSuccess: (payslipResponse) =>
              PayrollDetailsContent(payslipData: payslipResponse.data),
          getPayslipDetailsError: (error) => PayrollErrorHandler(error: error),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}