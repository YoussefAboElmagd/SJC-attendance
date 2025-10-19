import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Feature/leave/leave_managment/data/model/holiday_request.dart';
// import 'package:madarj/Feature/leave/leave_managment/data/model/new_holiday_response.dart';
import 'package:madarj/Feature/leave/leave_management/logic/cubit/leave_manager_details_cubit.dart';
import 'package:madarj/Feature/leave/leave_management/ui/widget/build_manager_tap.dart';
import 'package:madarj/Feature/leave/leave_management/ui/widget/list_of_manager_leave.dart';
import 'package:madarj/generated/l10n.dart';

class TabsManagerScreen extends StatefulWidget {
  const TabsManagerScreen({
    super.key,
    // this.requestsApprovedData,
    // this.requestsPendingData,
    // this.requestsRefusedData,
  });
  // final NewHolidayResponse? requestsApprovedData;
  // final NewHolidayResponse? requestsPendingData;
  // final NewHolidayResponse? requestsRefusedData;

  @override
  State<TabsManagerScreen> createState() => _TabsManagerScreenState();
}

class _TabsManagerScreenState extends State<TabsManagerScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LeaveManagerDetailsCubit>();
    List<Widget> screens = [
      ListOfManagerLeave(
        data: cubit.pendingData,
        isPending: true,
        selectedIndex: selectedIndex,
      ),
      ListOfManagerLeave(
        data: cubit.approvedData,
        isPending: false,
        selectedIndex: selectedIndex,
      ),
      ListOfManagerLeave(
        data: cubit.refusedData,
        isPending: false,
        selectedIndex: selectedIndex,
      ),
    ];

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(25.r),
              left: Radius.circular(25.r),
            ),
          ),
          child: Row(
            children: [
              BuildManagerTap(
                title: S.of(context).Review_Text,
                isSelected: selectedIndex == 0,
                badgeCount: 0,
                // badgeCount: widget.requestsPendingData!.count ?? 0,
                onTap: () {
                  setState(() => selectedIndex = 0);
                },
              ),
              BuildManagerTap(
                title: S.of(context).Approved_Text,
                isSelected: selectedIndex == 1,
                badgeCount: 0,
                // badgeCount: widget.requestsApprovedData!.count ?? 0,
                onTap: () {
                  setState(() => selectedIndex = 1);
                },
              ),
              BuildManagerTap(
                title: S.of(context).Rejected_text,
                isSelected: selectedIndex == 2,
                badgeCount: 0,
                // badgeCount: widget.requestsRefusedData!.count ?? 0,
                onTap: () {
                  setState(() => selectedIndex = 2);
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        screens[selectedIndex],
      ],
    );
  }
}
