import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Feature/leave/leave_details/ui/widget/total_leave.dart';
import 'package:madarj/Feature/tasks/ui/widget/burnout_stats_card.dart';
import 'package:madarj/Feature/tasks/ui/widget/tabs_screen_tasks.dart';
import 'package:madarj/Feature/tasks/ui/widget/total_leave.dart';

class TasksBodyWidgets extends StatelessWidget {
  const TasksBodyWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const TotalTasks(),
          SizedBox(height: 5.h),
          const BurnoutStatsCard(),
          SizedBox(height: 5.h),
          const TabsScreenTasks(),
        ],
      ),
    );
  }
}
