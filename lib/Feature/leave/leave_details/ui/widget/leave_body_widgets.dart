import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_request.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_summary.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/tabs_screen.dart';
// import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_body.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/total_leave.dart';

class LeaveBodyWidgets extends StatelessWidget {
  const LeaveBodyWidgets({
    super.key,
    this.timeoffBalanceData,
    this.requestsApprovedData,
    this.requestsPendingData,
    this.requestsRefusedData,
  });
  final HolidaySummaryResponse? timeoffBalanceData;
  final HolidayRequestResponse? requestsApprovedData;
  final HolidayRequestResponse? requestsPendingData;
  final HolidayRequestResponse? requestsRefusedData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TotalLeave(timeoffBalanceData: timeoffBalanceData),
        SizedBox(height: 15.h),
        TabsScreen(
          requestsApprovedData: requestsApprovedData,
          requestsPendingData: requestsPendingData,
          requestsRefusedData: requestsRefusedData,
        ),
      ],
    );
  }
}
