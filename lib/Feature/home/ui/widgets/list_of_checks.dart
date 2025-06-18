import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/home/data/model/get_today_work_response.dart';
import 'package:madarj/Feature/home/ui/widgets/daily_log_card.dart';
import 'package:madarj/Feature/home/ui/widgets/no_work_today.dart';
import 'package:madarj/generated/l10n.dart';

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
}

