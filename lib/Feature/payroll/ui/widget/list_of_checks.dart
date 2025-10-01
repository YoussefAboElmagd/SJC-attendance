import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/all_works/ui/widgets/no_month_work.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_response.dart';
import 'package:madarj/Feature/payroll/ui/widget/daily_log_card.dart';
import 'package:madarj/generated/l10n.dart';

class ListOfChecks extends StatelessWidget {
  final List<PayslipData>? data;

  const ListOfChecks({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data!.isEmpty) {
      return NoMonthWork(
        mainTitle: S.of(context).no_payroll_first,
        subTitle: S.of(context).no_payroll_second,
        secontTitle: S.of(context).no_payroll_second,
      );
    }

    return ListView.separated(
      itemCount: data!.length,
      separatorBuilder: (_, __) => SizedBox(height: 15.h),
      itemBuilder: (context, index) => DailyLogCard(payslipData: data![index]),
    );
  }
}
