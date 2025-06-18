import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';
import 'package:madarj/generated/l10n.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key, this.data});
  final ExpenseDetailsResponse? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).Expenses_description,
          style: TextStyles.font14BlackSemiBold,
        ),
        SizedBox(height: 4.h),
        Text(
          data!.data!.description ?? S.of(context).there_is_no_description,
          style: TextStyles.font14GreySemiBold,
        ),
        SizedBox(height: 10.h),
        Text(S.of(context).amount, style: TextStyles.font14BlackSemiBold),
        SizedBox(height: 4.h),
        Text(
          data!.data!.totalAmount.toString() ??
              S.of(context).there_is_no_description,
          style: TextStyles.font14GreySemiBold,
        ),
      ],
    );
  }
}
