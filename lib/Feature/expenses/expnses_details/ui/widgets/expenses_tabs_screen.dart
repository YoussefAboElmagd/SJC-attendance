import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/build_tap.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/list_of_expenses.dart';

class ExpensesTabsScreen extends StatefulWidget {
  const ExpensesTabsScreen({super.key});

  @override
  State<ExpensesTabsScreen> createState() => _ExpensesTabsScreenState();
}

class _ExpensesTabsScreenState extends State<ExpensesTabsScreen> {
  int selectedIndex = 0;

  List<Widget> screens = const [
    ListOfExpenses(),
    ListOfExpenses(),
    ListOfExpenses(),
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
                title: 'Review',
                isSelected: selectedIndex == 0,
                badgeCount: 3,
                onTap: () => setState(() => selectedIndex = 0),
              ),
              BuildTap(
                title: 'Approved',
                isSelected: selectedIndex == 1,
                badgeCount: 3,
                onTap: () => setState(() => selectedIndex = 1),
              ),
              BuildTap(
                title: 'Rejected',
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
