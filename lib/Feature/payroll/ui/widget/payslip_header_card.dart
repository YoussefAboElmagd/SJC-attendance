import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_details_response.dart';
import 'package:madarj/Feature/payroll/ui/widget/payslip_details_data.dart';
import 'package:madarj/Feature/payroll/ui/widget/payslip_title.dart';
import 'package:madarj/generated/l10n.dart';

class PayslipHeaderCard extends StatelessWidget {
  final PayslipDetailsData payslipData;

  const PayslipHeaderCard({super.key, required this.payslipData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PayslipTitle(name: S.of(context).Total_Working_Hour),

          SizedBox(height: 15.h),
          PayslipTitle(
            name:
                '${S.of(context).Paid_Period} 1 ${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().year} - 30 ${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().year}',
          ),
          SizedBox(height: 16.h),

          PayslipHeaderInfo(payslipData: payslipData),
        ],
      ),
    );
  }
}