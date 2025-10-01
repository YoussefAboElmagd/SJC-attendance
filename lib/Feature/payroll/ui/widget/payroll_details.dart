import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Feature/payroll/logic/cubit/payroll_cubit.dart';
import 'package:madarj/Feature/payroll/ui/widget/payroll_app_bar.dart';
import 'package:madarj/Feature/payroll/ui/widget/payroll_details_body.dart';

class PayrollDetails extends StatelessWidget {
  const PayrollDetails({super.key, this.payslipId});
  final String? payslipId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<PayrollCubit>()..getPayslipDetails(context,payslipId: payslipId ?? "1"),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: const PayrollAppBar(),
        body: const PayrollDetailsBody(),
      ),
    );
  }
}
