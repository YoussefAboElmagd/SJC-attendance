import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/expenses_details/ui/widgets/list_of_total_expenses.dart';
import 'package:madarj/generated/l10n.dart';

class TotalExpenses extends StatelessWidget {
  const TotalExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).Total_Expense_Text,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${S.of(context).Period_text} 1 ${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().year} - 30 ${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().year}',
                    style: TextStyles.font14BlackSemiBold.copyWith(
                      color: const Color.fromRGBO(71, 84, 103, 1),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  const ListOfTotalExpenses(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
