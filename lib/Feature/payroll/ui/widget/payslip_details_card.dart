import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_details_response.dart';
import 'package:madarj/Feature/payroll/ui/widget/payslip_details_title.dart';
import 'package:madarj/Feature/payroll/ui/widget/payslip_divider.dart';
import 'package:madarj/Feature/payroll/ui/widget/payslip_salary_breakdown.dart';
import 'package:madarj/Feature/payroll/ui/widget/payslip_status_badge.dart';

class PayslipDetailsCard extends StatelessWidget {
  final PayslipDetailsData payslipData;

  const PayslipDetailsCard({super.key, required this.payslipData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PayslipDetailsTitle(),
          SizedBox(height: 24.h),
          PayslipSalaryBreakdown(payslipData: payslipData),
          SizedBox(height: 20.h),
          const PayslipDivider(),
          SizedBox(height: 16.h),
          PayslipTotalSalary(payslipData: payslipData),
          SizedBox(height: 16.h),
          PayslipStatusBadge(status: payslipData.status ?? 'draft'),
        ],
      ),
    );
  }
}