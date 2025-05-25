import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/create_expense_request.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/send_expenses_body.dart';
import 'package:madarj/generated/l10n.dart';

class SendExpenses extends StatelessWidget {
  const SendExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SendExpensesCubit>(),
      child: Scaffold(
        backgroundColor: ColorsManager.mainGray,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20.w,
            ),
          ),
          centerTitle: true,
          title: Text(
            S.of(context).Submit_Expense,
            style: TextStyles.font20BlackSemiBold,
          ),
        ),
        body: const SendExpensesBody(),
        bottomNavigationBar: const BottomExpensesLeaveButton(),
      ),
    );
  }
}

class BottomExpensesLeaveButton extends StatelessWidget {
  const BottomExpensesLeaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            if (context
                .read<SendExpensesCubit>()
                .formKey
                .currentState!
                .validate()) {
              context.read<SendExpensesCubit>().createExpense(
                    CreateExpenseRequest(
                      categoryId: "19",
                      requestTypeId: "4",
                      description: context
                          .read<SendExpensesCubit>()
                          .expensesDescription!
                          .text
                          .toString(),
                      totalAmount: context
                          .read<SendExpensesCubit>()
                          .amountNumber!
                          .text
                          .toString(),
                      files: context.read<SendExpensesCubit>().selectedFiles,
                    ),
                  );
            }
          },
          child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(42, 49, 131, 1),
                  Color.fromRGBO(42, 49, 131, 1),
                  Color.fromRGBO(91, 46, 212, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                S.of(context).Submit_Leave_button,
                style: TextStyles.font16WhiteSemiBold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
