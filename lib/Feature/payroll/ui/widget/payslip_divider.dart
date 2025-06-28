import 'package:flutter/material.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_details_response.dart';
import 'package:madarj/generated/l10n.dart';

class PayslipDivider extends StatelessWidget {
  const PayslipDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: Colors.grey[300]);
  }
}

class PayslipTotalSalary extends StatelessWidget {
  final PayslipDetailsData payslipData;

  const PayslipTotalSalary({super.key, required this.payslipData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(S.of(context).Total_Salary, style: TextStyles.font16BlackSemiBold),
        Text(
          "\$${(payslipData.totalSalary ?? 0).toStringAsFixed(2)}",
          style: TextStyles.font16BlackSemiBold,
        ),
      ],
    );
  }
}