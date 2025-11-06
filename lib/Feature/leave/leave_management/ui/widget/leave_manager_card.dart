import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/leave_details_number.dart';
import 'package:madarj/Feature/leave/leave_management/data/model/holiday_summary.dart';
import 'package:madarj/Feature/leave/leave_management/ui/widget/leave_details_manager_number.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveManagerCard extends StatelessWidget {
  const LeaveManagerCard({super.key, this.timeoffBalanceData});
  final HolidaySummaryResponse? timeoffBalanceData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeaveManagerDetailsNumber(
              image: 'assets/images/orange_circle.png',
              title: S.of(context).Available_text,
              price: timeoffBalanceData!.data!.allRemaining.toString(),
              widget: Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            flex: 2,
            child: LeaveDetailsNumber(
              image: 'assets/images/orange_circle.png',
              title: S.of(context).Leave_Used,
              price: timeoffBalanceData!.data!.allSpent.toString(),
              widget: Container(
                width: 12.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: ColorsManager.mainColor1,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
