import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Feature/all_works/ui/widgets/error_dialog.dart';
import 'package:madarj/Feature/all_works/ui/widgets/list_of_checks_shimmer.dart';
import 'package:madarj/Feature/payroll/logic/cubit/payroll_cubit.dart';
import 'package:madarj/Feature/payroll/logic/cubit/payroll_state.dart';
import 'package:madarj/Feature/payroll/ui/widget/list_of_checks.dart';

class PayrollBuilder extends StatelessWidget {
  const PayrollBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayrollCubit, PayrollState>(
      buildWhen: (previous, current) =>
          current is GetEmployeePayslipsLoading ||
          current is GetEmployeePayslipsSuccess ||
          current is GetEmployeePayslipsError,
      builder: (context, state) {
        return state.maybeWhen(
          getEmployeePayslipsLoading: () => const ListOfChecksShimmer(),
          getEmployeePayslipsSuccess: (data) => ListOfChecks(data: data.data),
          getEmployeePayslipsError: (errorHandler) =>
              ErrorDialog(message: errorHandler.message!),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}