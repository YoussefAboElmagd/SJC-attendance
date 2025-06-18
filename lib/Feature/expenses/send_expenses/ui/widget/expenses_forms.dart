import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/request_types_model_response.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/send_exp_categories_model_response.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_drop_down.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_text_field.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';
import 'package:madarj/generated/l10n.dart';

class ExpensesForms extends StatelessWidget {
  const ExpensesForms({
    super.key,
    required this.requests,
    required this.categories,
    this.expenseDetail,
    this.update,
  });
  final RequestTypesModel requests;
  final SendExpCategResponse categories;
  final ExpenseDetailsResponse? expenseDetail;
  final bool? update;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendExpensesCubit, SendExpensesState>(
      builder: (context, state) {
        return Form(
          key: context.read<SendExpensesCubit>().formKey,
          child: Column(
            children: [
              BuildTextField(
                controller: context.read<SendExpensesCubit>().amountNumber,
                label: S.of(context).Expense_Amount,
                hint: update == true
                    ? expenseDetail!.data!.totalAmount.toString()
                    : S.of(context).Enter_Amount,
                icon: "assets/svgs/summary-expenses(3).svg",
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isNotEmptyOrNull()) {
                    return "${S.of(context).Expense_Amount} ${S.of(context).mustnot_be_empty}";
                  } else if (int.parse(val) < 1) {
                    return "${S.of(context).Expense_Amount} >0";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              BuildDropdown(
                controllerId: context.read<SendExpensesCubit>().departmentId,
                mapDrop: requests.requestTypes,
                controller: context.read<SendExpensesCubit>().departmentText,
                label: S.of(context).Department_text,
                hint: update == true
                    ? expenseDetail!.data!.requestName.toString()
                    : context
                              .read<SendExpensesCubit>()
                              .departmentText
                              ?.text
                              .isEmpty ??
                          true
                    ? S.of(context).Enter_Department
                    : context.read<SendExpensesCubit>().departmentText!.text,
                icon: "assets/svgs/summary-expenses(1).svg",
                errorText: context
                    .read<SendExpensesCubit>()
                    .departmentError, // Add error text
              ),
              SizedBox(height: 16.h),
              BuildDropdown(
                controllerId: context.read<SendExpensesCubit>().selectRequestId,
                mapDrop: categories.categories,
                controller: context.read<SendExpensesCubit>().selectRequestType,
                label: S.of(context).Select_Request_type,
                hint: update == true
                    ? expenseDetail!.data!.categoryName.toString()
                    : context
                              .read<SendExpensesCubit>()
                              .selectRequestType
                              ?.text
                              .isEmpty ??
                          true
                    ? S.of(context).Enter_Request_type
                    : context.read<SendExpensesCubit>().selectRequestType!.text,
                icon: "assets/svgs/summary-expenses(2).svg",
                errorText: context.read<SendExpensesCubit>().requestTypeError,
              ),
              SizedBox(height: 16.h),
              BuildTextField(
                controller: context
                    .read<SendExpensesCubit>()
                    .expensesDescription,
                label: S.of(context).Expense_Description,
                hint: S.of(context).Enter_Expense_Description,
                icon: null,
                maxLines: 3,
              ),
            ],
          ),
        );
      },
    );
  }
}
