import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/expenses/expnses_details/data/model/expenses_model.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/list_of_expenses.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/build_tap.dart';
import 'package:madarj/generated/l10n.dart';

class ExpensesTabsScreen extends StatefulWidget {
  const ExpensesTabsScreen(
      {super.key,
      required this.newExpensesData,
      required this.pendingExpensesData,
      required this.doneExpensesData});

  final ExpensesListResponse newExpensesData;
  final ExpensesListResponse pendingExpensesData;
  final ExpensesListResponse doneExpensesData;
  @override
  State<ExpensesTabsScreen> createState() => _ExpensesTabsScreenState();
}

class _ExpensesTabsScreenState extends State<ExpensesTabsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      NewExpenses(
        newExpensesData: widget.newExpensesData,
      ),
      PendingExpenses(
        pendingExpensesData: widget.pendingExpensesData,
      ),
      DoneExpenses(
        doneExpensesData: widget.doneExpensesData,
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
              BuildTap(
                title: S.of(context).new_section_text,
                isSelected: selectedIndex == 0,
                badgeCount: widget.newExpensesData.results!,
                onTap: () => setState(() => selectedIndex = 0),
              ),
              BuildTap(
                title: S.of(context).Pending_section_text,
                isSelected: selectedIndex == 1,
                badgeCount: widget.pendingExpensesData.results!,
                onTap: () => setState(() => selectedIndex = 1),
              ),
              BuildTap(
                title: S.of(context).done_section_text,
                isSelected: selectedIndex == 2,
                badgeCount: widget.doneExpensesData.results!,
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
