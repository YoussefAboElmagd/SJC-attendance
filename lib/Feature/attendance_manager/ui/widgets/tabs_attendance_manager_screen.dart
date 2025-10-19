import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/attendance_manager/logic/attendance_manager_cubit.dart';
// import 'package:madarj/Feature/attendance_manager/logic/attendance_manager_cubit.dart';
import 'package:madarj/Feature/attendance_manager/ui/widgets/build_attendance_manager_tap.dart';
import 'package:madarj/Feature/attendance_manager/ui/widgets/list_of_attendance_manager.dart';
// import 'package:madarj/Feature/leave/leave_managment/logic/cubit/leave_manager_details_cubit.dart';
import 'package:madarj/generated/l10n.dart';

class TabsAttendanceManagerScreen extends StatefulWidget {
  const TabsAttendanceManagerScreen({super.key});
  @override
  State<TabsAttendanceManagerScreen> createState() =>
      _TabsAttendanceManagerScreenState();
}

class _TabsAttendanceManagerScreenState
    extends State<TabsAttendanceManagerScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AttendanceManagerCubit>();
    List<Widget> screens = [
      ListOfAttendanceManager(
        data: cubit.pendingRequestItem,
        isPending: true,
        isApprove: false,
        selectedIndex: selectedIndex,
      ),
      ListOfAttendanceManager(
        data: cubit.acceptRequestItem,
        isPending: false,
        isApprove: true,
        selectedIndex: selectedIndex,
      ),
      ListOfAttendanceManager(
        data: cubit.refusedRequestItem,
        isPending: false,
        isApprove: false,
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
              BuildAttendanceManagerTap(
                title: S.of(context).Review_Text,
                isSelected: selectedIndex == 0,
                badgeCount: 0,
                // badgeCount: widget.requestsPendingData!.count ?? 0,
                onTap: () {
                  setState(() => selectedIndex = 0);
                },
              ),
              BuildAttendanceManagerTap(
                title: S.of(context).Approved_Text,
                isSelected: selectedIndex == 1,
                badgeCount: 0,
                // badgeCount: widget.requestsApprovedData!.count ?? 0,
                onTap: () {
                  setState(() => selectedIndex = 1);
                },
              ),
              BuildAttendanceManagerTap(
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
