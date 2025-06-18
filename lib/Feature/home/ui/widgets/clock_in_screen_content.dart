import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/home/ui/widgets/check_user_bloc_listener.dart';
import 'package:madarj/Feature/home/ui/widgets/clock_in_top_header.dart';
import 'package:madarj/Feature/home/ui/widgets/period_and_total_hours_builder.dart';

class ClockInScreenContent extends StatelessWidget {
  const ClockInScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const ClockInTopHeader(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SizedBox(
            height: (MediaQuery.sizeOf(context).height - 190.h),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PeriodAndTotalHoursBuilder(),
                CheckUserBlocListener(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
