import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_request.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/leave_log_card.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/no_leave_today.dart';

class ListOfLeave extends StatelessWidget {
  const ListOfLeave({super.key, this.data, this.isNew});
  final HolidayRequestResponse? data;
  final bool? isNew;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height - 550.h),
      child: data?.data == null || data!.data!.isEmpty
          ? const NoLeaveToday()
          : ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemBuilder: (context, index) {
                return index == data!.data!.length - 1
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 25.h),
                        child: LeaveLogCard(
                          data: data!.data![index],
                          isNew: isNew ?? false,
                        ),
                      )
                    : LeaveLogCard(
                        data: data!.data![index],
                        isNew: isNew ?? false,
                      );
              },
              separatorBuilder: (context, index) => SizedBox(height: 15.h),
              itemCount: data!.data!.length,
            ),
    );
  }
}
