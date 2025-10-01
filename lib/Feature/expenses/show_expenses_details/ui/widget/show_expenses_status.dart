import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';

class ShowExpensesStatus extends StatelessWidget {
  const ShowExpensesStatus({
    super.key,
    required this.isApproved,
    this.color,
  });

  final String? isApproved;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          20.r,
        ),
      ),
      child: Text(
        isApproved!,
        style: TextStyles.font16WhiteSemiBold,
      ),
    );
  }
}
