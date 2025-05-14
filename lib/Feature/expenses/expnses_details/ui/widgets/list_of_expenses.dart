import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_log_card.dart';
import 'package:madarj/Feature/home/ui/widgets/list_of_checks.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/no_leave_today.dart';

class DoneExpenses extends StatelessWidget {
  DoneExpenses({
    super.key,
  });
  final List<bool> reqStatus = [
    true,
    false,
    true,
    false,
    true,
    false,
    true,
    false,
    true,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height - 320.h),
      child: false
          ? const NoLeaveToday()
          : Container(
              decoration: const BoxDecoration(),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      InkWell(
                        child: ExpensesLogCard(
                          isApproved: reqStatus[index],
                          rejected: !reqStatus[index],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 15.h,
                ),
                itemCount: reqStatus.length,
              ),
            ),
    );
  }
}

class NewExpenses extends StatelessWidget {
  const NewExpenses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height - 320.h),
      child: false
          ? const NoLeaveToday()
          : Container(
              decoration: const BoxDecoration(),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      const InkWell(
                        child: ExpensesLogCard(
                          isNew: true,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 15.h,
                ),
                itemCount: 10,
              ),
            ),
    );
  }
}

class PendingExpenses extends StatelessWidget {
  const PendingExpenses({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height - 320.h),
      child: false
          ? const NoLeaveToday()
          : Container(
              decoration: const BoxDecoration(),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      const InkWell(
                        child: ExpensesLogCard(
                          pending: true,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 15.h,
                ),
                itemCount: 10,
              ),
            ),
    );
  }
}
