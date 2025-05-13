import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_body.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/build_tap.dart';
import 'package:madarj/Feature/tasks/tasks_details/ui/widget/list_of_tasks.dart';
import 'package:madarj/generated/l10n.dart';

class TabsScreenTasks extends StatefulWidget {
  const TabsScreenTasks({super.key});

  @override
  State<TabsScreenTasks> createState() => _TabsScreenTasksState();
}

class _TabsScreenTasksState extends State<TabsScreenTasks> {
  int selectedIndex = 0;

  List<Widget> screens = const [
    ListOfTasks(),
    ListOfTasks(),
    ListOfTasks(),
  ];

  @override
  Widget build(BuildContext context) {
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
                badgeCount: 3,
                onTap: () => setState(() => selectedIndex = 0),
              ),
              BuildTap(
                title: S.of(context).Approved_Text,
                isSelected: selectedIndex == 1,
                badgeCount: 3,
                onTap: () => setState(() => selectedIndex = 1),
              ),
              BuildTap(
                title: S.of(context).Rejected_text,
                isSelected: selectedIndex == 2,
                badgeCount: 3,
                onTap: () => setState(() => selectedIndex = 2),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        screens[selectedIndex], // العرض حسب المؤشر
      ],
    );
  }
}