import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/all_works/data/model/get_month_work_response.dart';
import 'package:madarj/Feature/all_works/ui/widgets/card_details.dart';

class DailyLogCard extends StatelessWidget {
  final WorkDayEntry workDayEntry;

  const DailyLogCard({super.key, required this.workDayEntry});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                workDayEntry.date!.toArabicDate(),
                style: TextStyles.font14BlackSemiBold,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          CardDetails(workDayEntry: workDayEntry),
        ],
      ),
    );
  }
}
