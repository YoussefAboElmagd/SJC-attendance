import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_log_card.dart';
import 'package:madarj/Feature/home/ui/widgets/list_of_checks.dart';

class ListOfExpenses extends StatelessWidget {
  const ListOfExpenses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height - 550.h),
      child: false
          ? const NoWorkToday()
          : ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemBuilder: (context, index) {
                return index == 9
                    ? Padding(
                        padding: EdgeInsets.only(
                          bottom: 25.h,
                        ),
                        child: const ExpensesLogCard(),
                      )
                    : const ExpensesLogCard();
              },
              separatorBuilder: (context, index) => SizedBox(height: 15.h),
              itemCount: 10,
            ),
    );
  }
}
