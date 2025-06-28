import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_details_response.dart';
import 'package:madarj/Feature/payroll/ui/widget/payroll_line_item.dart';
import 'package:madarj/generated/l10n.dart';

class PayslipSalaryBreakdown extends StatelessWidget {
  final PayslipDetailsData payslipData;

  const PayslipSalaryBreakdown({super.key, required this.payslipData});

  @override
  Widget build(BuildContext context) {
    final deductionsAmount =
        payslipData.totalSalary != null && payslipData.payslipNet != null
        ? (payslipData.totalSalary! - payslipData.payslipNet!).toStringAsFixed(
            2,
          )
        : '0.00';

    return Column(
      children: [
        PayrollLineItem(
          title: S.of(context).Basic_Salary,
          amount: "\$${(payslipData.totalSalary ?? 0).toStringAsFixed(2)}",
          amountColor: Colors.black,
        ),
        SizedBox(height: 16.h),
        PayrollLineItem(
          title: S.of(context).Allowances,
          amount: "+\$${(payslipData.xTotal ?? 0).toStringAsFixed(2)}",
          amountColor: Colors.green,
        ),
        SizedBox(height: 16.h),
        PayrollLineItem(
          title: S.of(context).Deductions,
          amount: "-\$$deductionsAmount",
          amountColor: Colors.red,
        ),
      ],
    );
  }
}