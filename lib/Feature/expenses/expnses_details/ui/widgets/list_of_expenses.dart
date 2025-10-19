import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/expnses_details/data/model/expenses_model.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_log_card.dart';
import 'package:madarj/generated/l10n.dart';

class DoneExpenses extends StatelessWidget {
  const DoneExpenses({super.key, required this.doneExpensesData});
  final ExpensesListResponse doneExpensesData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height - 320.h),
      child:
          doneExpensesData.data.isNotEmptyOrNull() ||
              doneExpensesData.results == 0
          ? NoExpenses(status: S.of(context).done_section_text)
          : Container(
              decoration: const BoxDecoration(),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      InkWell(
                        onTap: () {
                          // print(doneExpensesData.data![index].status);
                          if (doneExpensesData.data![index].status!
                                  .toLowerCase() ==
                              "refused") {
                            context.pushNamed(
                              Routes.showExpensesDetailsBody,
                              arguments: {
                                'isApproved': false,
                                'rejected': true,
                                'pending': false,
                                'isNew': false,
                                'id': doneExpensesData.data![index].id,
                              },
                            );
                          } else {
                            context.pushNamed(
                              Routes.showExpensesDetailsBody,
                              arguments: {
                                'isApproved': true,
                                'rejected': false,
                                'pending': false,
                                'isNew': false,
                                'id': doneExpensesData.data![index].id,
                              },
                            );
                          }
                        },
                        child: ExpensesLogCard(
                          data: doneExpensesData.data![index],
                          isApproved:
                              doneExpensesData.data![index].status ==
                                  "approved" ||
                              doneExpensesData.data![index].status == "done",
                          rejected:
                              doneExpensesData.data![index].status == "refused",
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 15.h),
                itemCount: doneExpensesData.data!.length,
              ),
            ),
    );
  }
}

class NewExpenses extends StatelessWidget {
  const NewExpenses({super.key, required this.newExpensesData});
  final ExpensesListResponse newExpensesData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height - 320.h),
      child:
          newExpensesData.data.isNotEmptyOrNull() ||
              newExpensesData.results == 0
          ? NoExpenses(status: S.of(context).new_section_text)
          : Container(
              decoration: const BoxDecoration(),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      InkWell(
                        onTap: () {
                          context.pushNamed(
                            Routes.showExpensesDetailsBody,
                            arguments: {
                              'isApproved': false,
                              'rejected': false,
                              'pending': false,
                              'isNew': true,
                              'id': newExpensesData.data![index].id,
                            },
                          );
                        },
                        child: ExpensesLogCard(
                          isNew: true,
                          data: newExpensesData.data![index],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 15.h),
                itemCount: newExpensesData.data!.length,
              ),
            ),
    );
  }
}

class PendingExpenses extends StatelessWidget {
  const PendingExpenses({super.key, required this.pendingExpensesData});
  final ExpensesListResponse pendingExpensesData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height - 320.h),
      child:
          pendingExpensesData.data.isNotEmptyOrNull() ||
              pendingExpensesData.results == 0
          ? NoExpenses(status: S.of(context).Pending_section_text)
          : Container(
              decoration: const BoxDecoration(),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      InkWell(
                        onTap: () {
                          context.pushNamed(
                            Routes.showExpensesDetailsBody,
                            arguments: {
                              'isApproved': false,
                              'rejected': false,
                              'pending': true,
                              'isNew': false,
                              'id': pendingExpensesData.data![index].id,
                            },
                          );
                        },
                        child: ExpensesLogCard(
                          pending: true,
                          data: pendingExpensesData.data![index],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 15.h),
                itemCount: pendingExpensesData.data!.length,
              ),
            ),
    );
  }
}

class NoExpenses extends StatelessWidget {
  const NoExpenses({super.key, this.status});
  final String? status;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 10.h,
            right: 5.w,
            left: 5.w,
          ),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 12.0.h, right: 12.0.w, left: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).Expense_text,
                      style: TextStyles.font18BlackBold,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "${S.of(context).Expense_text} $status",
                      style: TextStyles.font14BlackSemiBold.copyWith(
                        color: ColorsManager.gray,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.h, right: 50.w, left: 50.w),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/svgs/no_exp.svg",
                      width: 200.w,
                      height: 120.h,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${S.of(context).No_Expense} $status",
                      style: TextStyles.font16BlackSemiBold,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 8.w,
                      ),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "${S.of(context).It_looks_like_you_have_any_expense} ${S.of(context).Expense_text} $status",
                          style: TextStyles.font14GreyRegular,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
