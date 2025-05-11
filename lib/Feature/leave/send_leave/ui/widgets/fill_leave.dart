import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';


class FillLeave extends StatelessWidget {
  const FillLeave({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF3B3B98),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).Fill_Leave_Information,
            style: TextStyles.font18WhiteSemiBold,
          ),
          SizedBox(height: 4.h),
          Text(
            S.of(context).Information_leave_details,
            style: TextStyles.font14GreyRegular,
          ),
        ],
      ),
    );
  }
}