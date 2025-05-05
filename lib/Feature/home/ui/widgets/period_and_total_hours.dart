import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/home/data/model/pay_period_response.dart';
import 'package:madarj/Feature/home/data/model/total_hours.dart';
import 'package:madarj/generated/l10n.dart';

class PeriodAndTotalHours extends StatelessWidget {
  const PeriodAndTotalHours({
    super.key,
    required this.payPeriodResponse,
    required this.totalHours,
  });
  final PayPeriodResponse payPeriodResponse;
  final TotalHours totalHours;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: ColorsManager.grey2,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).Today,
                  style: TextStyles.font14BlackSemiBold,
                ),
                SizedBox(height: 4.h),
                Text(
                  totalHours.totalHours!,
                  style: TextStyles.font18BlackNormal,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(
                12.r,
              ),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).Paid_Period,
                  style: TextStyles.font14BlackSemiBold,
                ),
                SizedBox(height: 4.h),
                Text(
                  payPeriodResponse.totalTimeForThisMonth!,
                  style: TextStyles.font18BlackNormal,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
