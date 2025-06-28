import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';


class PayrollLineItem extends StatelessWidget {
  final String title;
  final String amount;
  final Color amountColor;

  const PayrollLineItem({
    super.key,
    required this.title,
    required this.amount,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyles.font15DarkBlueMedium),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: amountColor,
          ),
        ),
      ],
    );
  }
}
