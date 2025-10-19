import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Feature/expenses/expenses_details/data/model/expenses_model.dart';
import 'package:madarj/generated/l10n.dart';

class ExpensesLogCard extends StatelessWidget {
  const ExpensesLogCard({
    super.key,
    this.isApproved,
    this.rejected,
    this.pending,
    this.isNew,
    this.data,
  });
  final bool? isApproved;
  final bool? rejected;
  final bool? pending;
  final bool? isNew;
  final ExpenseData? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svgs/expenses.svg"),
                const SizedBox(width: 4),
                Text("${data!.date}", style: TextStyles.font14BlackSemiBold),
                const Spacer(),
                isApproved == true
                    ? Text(
                      S.of(context).Approved_Text,
                      style: TextStyles.font16GreenSemiBold,
                    )
                    : Container(),
                rejected == true
                    ? Text(
                      S.of(context).Rejected_text,
                      style: TextStyles.font16RedSemiBold,
                    )
                    : Container(),
                pending == true
                    ? Text(
                      S.of(context).Pending_section_text,
                      style: TextStyles.font16BlueSemiBold,
                    )
                    : Container(),
                isNew == true
                    ? AppTextButton(
                      buttonWidth: 50.w,
                      buttonHeight: 20.h,
                      borderRadius: 15,
                      buttonText: S.of(context).edit_button,
                      backgroundColor: ColorsManager.mainColor1,
                      textStyle: TextStyles.font14WhiteSemiBold,
                      onPressed: () {
                        context.pushNamed(
                          Routes.sendExpenses,
                          arguments: {"update": true, "id": data!.id},
                        );
                      },
                      hintText: S.of(context).edit_button,
                    )
                    : Container(),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Request_type,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(71, 84, 103, 1),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${data!.name}",
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Total_Expense_Text,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(71, 84, 103, 1),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${data!.totalAmount}\$",
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
