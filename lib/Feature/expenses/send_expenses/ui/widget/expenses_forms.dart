import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_drop_down.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_text_field.dart';
import 'package:madarj/generated/l10n.dart';

class ExpensesForms extends StatelessWidget {
  const ExpensesForms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendExpensesCubit, SendExpensesState>(
      builder: (context, state) {
        return Column(
          children: [
            BuildTextField(
              label: S.of(context).Expense_Amount,
              hint: S.of(context).Enter_Amount,
              icon: "assets/svgs/summary-expenses(3).svg",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.h),
            BuildDropdown(
              controller: context.read<SendExpensesCubit>().departmentText,
              label: S.of(context).Department_text,
              hint: context
                          .read<SendExpensesCubit>()
                          .departmentText
                          ?.text
                          .isEmpty ??
                      true
                  ? S.of(context).Enter_Department
                  : context.read<SendExpensesCubit>().departmentText!.text,
              icon: "assets/svgs/summary-expenses(1).svg",
              items: const [
                "ssss2",
                "ssss1",
                "ssss3",
                "ssss4",
                "ssss5",
                "ssss6",
                "ssss7",
                "ssss8",
              ],
            ),
            SizedBox(height: 16.h),
            BuildDropdown(
              controller: context.read<SendExpensesCubit>().selectRequestType,
              label: S.of(context).Select_Request_type,
              hint: context
                          .read<SendExpensesCubit>()
                          .selectRequestType
                          ?.text
                          .isEmpty ??
                      true
                  ? S.of(context).Enter_Request_type
                  : context.read<SendExpensesCubit>().selectRequestType!.text,

              // hint: S.of(context).Enter_Transaction_Date,
              icon: "assets/svgs/summary-expenses(2).svg",
              items: const [
                "ssss2",
                "ssss1",
                "ssss3",
                "ssss4",
                "ssss5",
                "ssss6",
                "ssss7",
                "ssss8",
              ],
            ),
            SizedBox(height: 16.h),
            BuildTextField(
              label: S.of(context).Expense_Description,
              hint: S.of(context).Enter_Expense_Description,
              icon: null,
              maxLines: 3,
            ),
          ],
        );
      },
    );
  }
}
