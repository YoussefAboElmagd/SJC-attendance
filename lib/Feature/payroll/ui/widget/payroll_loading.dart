import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_details_response.dart';
import 'package:madarj/Feature/payroll/ui/widget/payslip_details_card.dart';
import 'package:madarj/Feature/payroll/ui/widget/payslip_header_card.dart';

class PayrollLoadingWidget extends StatelessWidget {
  const PayrollLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(color: ColorsManager.mainColor2);
  }
}

class PayrollDetailsContent extends StatelessWidget {
  final PayslipDetailsData payslipData;

  const PayrollDetailsContent({super.key, required this.payslipData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PayslipHeaderCard(payslipData: payslipData),
          SizedBox(height: 15.h),
          PayslipDetailsCard(payslipData: payslipData),
        ],
      ),
    );
  }
}
