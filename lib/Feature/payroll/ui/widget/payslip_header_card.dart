import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/extensions.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          PayslipTitle(
            name:
                '${S.of(context).Paid_Period} 1 ${CachHelper.getData(key: "app_lang") == "ar" ? payslipData.period!.split("to")[1].trim().toArabicDate().split(" ")[1] : payslipData.period!.split("to")[1].trim().split(" ")[1]}  - ${CachHelper.getData(key: "app_lang") == "ar" ? payslipData.period!.split("to")[1].trim().toArabicDate().split(" ")[0] : payslipData.period!.split("to")[1].trim().split(" ")[0]} ${CachHelper.getData(key: "app_lang") == "ar" ? payslipData.period!.split("to")[1].trim().toArabicDate().split(" ")[1] : payslipData.period!.split("to")[1].trim().split(" ")[1]}',
          ),
        ],
      ),
    );
  }
}
