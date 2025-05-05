import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/leave_log_card.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/no_leave_today.dart';


class ListOfExpenses extends StatelessWidget {
  const ListOfExpenses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height - 550.h),
      child: false
          ? const NoLeaveToday()
          : Container(
              decoration: const BoxDecoration(),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      const LeaveLogCard(),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 15.h),
                itemCount: 10,
              ),
            ),
    );
  }
}

