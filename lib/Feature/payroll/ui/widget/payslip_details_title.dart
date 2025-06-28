import 'package:flutter/material.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class PayslipDetailsTitle extends StatelessWidget {
  const PayslipDetailsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).Payroll_Details,
      style: TextStyles.font16BlackSemiBold,
    );
  }
}