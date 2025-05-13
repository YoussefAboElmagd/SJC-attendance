import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/expenses/expnses_details/logic/cubit/expenses_cubit.dart';
import 'package:madarj/Feature/expenses/expnses_details/logic/cubit/expenses_state.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/bottom_expenses_button.dart';
// import 'package:madarj/Feature/expenses/expnses_details/ui/expenses.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_body_widgets.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_top_header.dart';

class ExpensesBody extends StatelessWidget {
  const ExpensesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      builder: (context, state) {
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
                    height: (MediaQuery.sizeOf(context).height - 250.h),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpensesBodyWidgets(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const BottomExpensesButton(),
          ],
        );
      },
    );
  }
}

