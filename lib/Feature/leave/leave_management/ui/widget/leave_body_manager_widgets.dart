import 'package:flutter/material.dart';
import 'package:madarj/Feature/leave/leave_management/data/model/holiday_summary.dart';
import 'package:madarj/Feature/leave/leave_management/ui/widget/tabs_manager_screen.dart';

class LeaveBodyManagerWidgets extends StatelessWidget {
  const LeaveBodyManagerWidgets({super.key, this.timeoffBalanceData});
  final HolidaySummaryResponse? timeoffBalanceData;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // TotalManagerLeave(timeoffBalanceData: timeoffBalanceData),
        // SizedBox(height: 15.h),
        TabsManagerScreen(),
      ],
    );
  }
}
