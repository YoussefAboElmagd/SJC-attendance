import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/all_works/data/model/get_month_work_response.dart';
import 'package:madarj/Feature/all_works/ui/widgets/daily_log_card.dart';
import 'package:madarj/Feature/all_works/ui/widgets/no_month_work.dart';

class ListOfChecks extends StatelessWidget {
  final List<WorkDayEntry> workDayEntries;

  const ListOfChecks({super.key, required this.workDayEntries});

  @override
  Widget build(BuildContext context) {
    if (workDayEntries.isEmpty) return const NoMonthWork();

    return ListView.separated(
      itemCount: workDayEntries.length,
      separatorBuilder: (_, __) => SizedBox(height: 15.h),
      itemBuilder: (context, index) => DailyLogCard(
        workDayEntry: workDayEntries[index],
      ),
    );
  }
}
