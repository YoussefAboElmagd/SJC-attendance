import 'package:flutter/material.dart';
import 'package:madarj/Feature/expenses/expnses_details/data/model/expenses_model.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_tabs_screen.dart';

class ExpensesBodyWidgets extends StatelessWidget {
  const ExpensesBodyWidgets(
      {super.key,
      required this.newExpensesData,
      required this.pendingExpensesData,
      required this.doneExpensesData});

  final ExpensesListResponse newExpensesData;
  final ExpensesListResponse pendingExpensesData;
  final ExpensesListResponse doneExpensesData;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        ExpensesTabsScreen(
          newExpensesData: newExpensesData,
          pendingExpensesData: pendingExpensesData,
          doneExpensesData: doneExpensesData,
        ),
      ],
    );
  }
}
