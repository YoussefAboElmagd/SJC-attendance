import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/create_expense_request.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/generated/l10n.dart';

class BottomSendExpensesButton extends StatelessWidget {
  const BottomSendExpensesButton({super.key, this.update, this.id});
  final bool? update;
  final int? id;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            if (update == false) {
              if (context
                      .read<SendExpensesCubit>()
                      .formKey
                      .currentState!
                      .validate() &&
                  context.read<SendExpensesCubit>().validateForm()) {
                context.read<SendExpensesCubit>().createExpense(
                  context,
                  CreateExpenseRequest(
                    categoryId: context
                        .read<SendExpensesCubit>()
                        .selectRequestId!
                        .text
                        .toString(),
                    requestTypeId: context
                        .read<SendExpensesCubit>()
                        .departmentId!
                        .text
                        .toString(),
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
            } else if (update == true) {
              if (context.read<SendExpensesCubit>().selectRequestId?.text ==
                      "" &&
                  context.read<SendExpensesCubit>().departmentId?.text == "" &&
                  context.read<SendExpensesCubit>().amountNumber?.text == "" &&
                  context.read<SendExpensesCubit>().expensesDescription?.text ==
                      "" &&
                  context.read<SendExpensesCubit>().selectedFiles.isEmpty) {
                Fluttertoast.showToast(
                  msg: S.of(context).you_should_edit_at_least_one,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0.sp,
                );
              } else {
                context.read<SendExpensesCubit>().editExpense(
                  context,
                  id!,
                  CreateExpenseRequest(
                    categoryId:
                        context
                                .read<SendExpensesCubit>()
                                .selectRequestId
                                ?.text !=
                            ""
                        ? context
                              .read<SendExpensesCubit>()
                              .selectRequestId
                              ?.text
                        : context
                              .read<SendExpensesCubit>()
                              .expense!
                              .data!
                              .categoryId
                              .toString(),
                    requestTypeId:
                        context.read<SendExpensesCubit>().departmentId?.text !=
                            ""
                        ? context.read<SendExpensesCubit>().departmentId?.text
                        : context
                              .read<SendExpensesCubit>()
                              .expense!
                              .data!
                              .requestTypeId
                              .toString(),
                    description:
                        context
                                .read<SendExpensesCubit>()
                                .expensesDescription!
                                .text
                                .toString() !=
                            ""
                        ? context
                              .read<SendExpensesCubit>()
                              .expensesDescription!
                              .text
                              .toString()
                        : context
                              .read<SendExpensesCubit>()
                              .expense!
                              .data!
                              .description
                              .toString(),
                    totalAmount:
                        context.read<SendExpensesCubit>().amountNumber?.text !=
                            ""
                        ? context.read<SendExpensesCubit>().amountNumber?.text
                        : context
                              .read<SendExpensesCubit>()
                              .expense!
                              .data!
                              .totalAmount
                              .toString(),
                    files: context.read<SendExpensesCubit>().selectedFiles,
                  ),
                );
              }
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
