import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/leave/leave_details/data/model/holiday_request.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/build_tap.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/list_of_leave.dart';
import 'package:madarj/generated/l10n.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({
    super.key,
    this.requestsApprovedData,
    this.requestsPendingData,
    this.requestsRefusedData,
  });
  final HolidayRequestResponse? requestsApprovedData;
  final HolidayRequestResponse? requestsPendingData;
  final HolidayRequestResponse? requestsRefusedData;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      ListOfLeave(data: widget.requestsPendingData, isNew: true),
      ListOfLeave(data: widget.requestsApprovedData),
      ListOfLeave(data: widget.requestsRefusedData),
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
              BuildTap(
                title: S.of(context).Review_Text,
                isSelected: selectedIndex == 0,
                badgeCount: widget.requestsPendingData!.count!,
                onTap: () => setState(() => selectedIndex = 0),
              ),
              BuildTap(
                title: S.of(context).Approved_Text,
                isSelected: selectedIndex == 1,
                badgeCount: widget.requestsApprovedData!.count!,
                onTap: () => setState(() => selectedIndex = 1),
              ),
              BuildTap(
                title: S.of(context).Rejected_text,
                isSelected: selectedIndex == 2,
                badgeCount: widget.requestsRefusedData!.count!,
                onTap: () => setState(() => selectedIndex = 2),
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
