import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class ExpensesTopHeader extends StatelessWidget {
  const ExpensesTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 235.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(42, 49, 131, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    S.of(context).Expense_Summary,
                    style: TextStyles.font26WhiteBold,
                  ),
                  Text(
                    S.of(context).Claim_expenses,
                    // "Don’t miss your clock in schedule",
                    style: TextStyles.font14GreyRegular.copyWith(
                      color: const Color.fromRGBO(217, 214, 254, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15.w),
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/images/visa.png",
                  height: 100.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
