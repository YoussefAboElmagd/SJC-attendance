import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Feature/leave/leave_managment/data/model/holiday_request.dart';
import 'package:madarj/Feature/leave/leave_managment/data/model/holiday_summary.dart';
// import 'package:madarj/Feature/leave/leave_managment/data/model/new_holiday_response.dart';
import 'package:madarj/Feature/leave/leave_managment/ui/widget/tabs_manager_screen.dart';
import 'package:madarj/Feature/leave/leave_managment/ui/widget/total_manager_leave.dart';

class LeaveBodyManagerWidgets extends StatelessWidget {
  const LeaveBodyManagerWidgets({
    super.key,
    this.timeoffBalanceData,
    // this.requestsApprovedData,
    // this.requestsPendingData,
    // this.requestsRefusedData,
  });
  final HolidaySummaryResponse? timeoffBalanceData;
  // final NewHolidayResponse? requestsApprovedData;
  // final NewHolidayResponse? requestsPendingData;
  // final NewHolidayResponse? requestsRefusedData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TotalManagerLeave(timeoffBalanceData: timeoffBalanceData),
        SizedBox(height: 15.h),
        const TabsManagerScreen(
          // requestsApprovedData: requestsApprovedData,
          // requestsPendingData: requestsPendingData,
          // requestsRefusedData: requestsRefusedData,
        ),
      ],
    );
  }
}
