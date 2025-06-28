import 'package:flutter/material.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_response.dart';

class DailyLogCard extends StatelessWidget {
  final PayslipData workDayEntry;

  const DailyLogCard({super.key, required this.workDayEntry});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.payrollDetails);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svgs/calendar.svg"),
                SizedBox(width: 4.w),
                Text(
                  workDayEntry.name!.split(" ")[5].replaceFirst("-", " "),
                  style: TextStyles.font14BlackSemiBold,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // CardDetails(workDayEntry: workDayEntry),
          ],
        ),
      ),
    );
  }
}