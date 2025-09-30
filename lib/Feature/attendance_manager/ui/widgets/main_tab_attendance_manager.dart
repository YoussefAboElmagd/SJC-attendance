import 'package:flutter/material.dart';
import 'package:madarj/Feature/attendance_manager/ui/widgets/tabs_attendance_manager_screen.dart';

class MainTabAttendanceManager extends StatelessWidget {
  const MainTabAttendanceManager({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // TotalAttendanceManager(allEditRequestsModel: allEditRequestsModel),
        // SizedBox(height: 15.h),
        TabsAttendanceManagerScreen(),
      ],
    );
  }
}
