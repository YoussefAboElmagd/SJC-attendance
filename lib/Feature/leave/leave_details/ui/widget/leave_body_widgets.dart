import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/tabs_screen.dart';
// import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_body.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/total_leave.dart';

class LeaveBodyWidgets extends StatelessWidget {
  const LeaveBodyWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TotalLeave(),
        SizedBox(height: 15.h),
        const TabsScreen(),
      ],
    );
  }
}
