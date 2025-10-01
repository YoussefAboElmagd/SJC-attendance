import 'package:flutter/material.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class PayslipTitle extends StatelessWidget {
  final String? name;

  const PayslipTitle({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name ?? S.of(context).Salary_Slip,
          style: TextStyles.font14BlackSemiBold,
        ),
      ],
    );
  }
}