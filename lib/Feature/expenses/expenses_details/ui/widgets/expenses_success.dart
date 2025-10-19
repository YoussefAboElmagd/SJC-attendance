import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/expenses/expenses_details/data/model/expenses_model.dart';
import 'package:madarj/Feature/expenses/expenses_details/ui/widgets/bottom_expenses_button.dart';
import 'package:madarj/Feature/expenses/expenses_details/ui/widgets/expenses_body_widgets.dart';
import 'package:madarj/Feature/expenses/expenses_details/ui/widgets/expenses_top_header.dart';

class ExpensesSuccess extends StatelessWidget {
  const ExpensesSuccess({
    super.key,
    required this.newExpensesData,
    required this.pendingExpensesData,
    required this.doneExpensesData,
  });
  final ExpensesListResponse newExpensesData;
  final ExpensesListResponse pendingExpensesData;
  final ExpensesListResponse doneExpensesData;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const ExpensesTopHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SizedBox(
                height: (MediaQuery.sizeOf(context).height - 220.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpensesBodyWidgets(
                      newExpensesData: newExpensesData,
                      pendingExpensesData: pendingExpensesData,
                      doneExpensesData: doneExpensesData,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const BottomExpensesButton(),
      ],
    );
  }
}
