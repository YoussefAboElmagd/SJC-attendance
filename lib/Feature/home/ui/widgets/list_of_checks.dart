import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/home/data/model/get_today_work_response.dart';
import 'package:madarj/Feature/home/ui/widgets/daily_log_card.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class ListOfchecks extends StatelessWidget {
  const ListOfchecks({
    super.key,
    required this.workDayEntries,
  });

  final List<TodayWorkDayEntry> workDayEntries;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: workDayEntries.isEmpty
          ? const NoWorkToday()
          : ListView.separated(
              itemBuilder: (context, index) {
                return index == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                S.of(context).Today_schedule,
                                style: TextStyles.font16BlackSemiBold,
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  context.pushNamed(Routes.allMonthWorks);
                                },
                                child: Text(
                                  S.of(context).view_month_work,
                                  style: TextStyles.font16BlackNormal.copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          DailyLogCard(
                            workDayEntry: workDayEntries[index],
                          ),
                        ],
                      )
                    : DailyLogCard(
                        workDayEntry: workDayEntries[index],
                      );
              },
              separatorBuilder: (context, index) => SizedBox(height: 15.h),
              itemCount: workDayEntries.length,
            ),
    );
  }
// ``
  // String _formatDate(String? date,context) {
  //   return date ?? S.of(context).No_date;
  // }

  // String _formatTime(String time) {
  //   return time;
  // }
}

class NoWorkToday extends StatelessWidget {
  const NoWorkToday({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              S.of(context).Today_schedule,
              style: TextStyles.font16BlackSemiBold,
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                context.pushNamed(Routes.allMonthWorks);
              },
              child: Text(
                S.of(context).view_month_work,
                style: TextStyles.font16BlackNormal.copyWith(
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 10.h,
            right: 5.w,
            left: 5.w,
          ),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                15.r,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 12.0.h,
              // bottom: 5.0,
              right: 12.0.w,
              left: 12.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).Working_Period_text,
                      style: TextStyles.font14BlackSemiBold,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      S.of(context).working_time_text,
                      style: TextStyles.font14CyranRegular.copyWith(
                        color: ColorsManager.gray,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 50.h,
                    right: 50.w,
                    left: 50.w,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/svgs/no_work_today.svg",
                      width: 140.w,
                      height: 90.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).No_work_entries_available_text,
                      style: TextStyles.font14BlackSemiBold,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          S.of(context).have_any_working_text,
                          style: TextStyles.font10GreyRegular,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ListOfchecksShimmer extends StatelessWidget {
  const ListOfchecksShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return const DailyLogCardShimmer();
        },
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
        itemCount: 10,
      ),
    );
  }
}

class DailyLogCardShimmer extends StatelessWidget {
  const DailyLogCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.r,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date shimmer
              Container(
                width: 120.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 8.h),
              // Main content shimmer
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left column shimmer
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.w,
                          height: 12.h,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: 60.w,
                          height: 16.h,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    // Right column shimmer
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100.w,
                          height: 12.h,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: 120.w,
                          height: 16.h,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
