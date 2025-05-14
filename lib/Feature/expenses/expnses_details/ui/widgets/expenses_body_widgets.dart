import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_tabs_screen.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/total_expenses.dart';

class ExpensesBodyWidgets extends StatelessWidget {
  const ExpensesBodyWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // const TotalExpenses(),
        // SizedBox(height: 15.h),
        ExpensesTabsScreen(),
      ],
    );
  }
}
