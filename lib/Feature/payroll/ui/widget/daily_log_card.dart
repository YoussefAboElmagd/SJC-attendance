import 'package:flutter/material.dart';
import 'package:madarj/Core/helpers/cache_helper.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/payroll/data/model/payslip_response.dart';
import 'package:madarj/generated/l10n.dart';

class DailyLogCard extends StatelessWidget {
  final PayslipData payslipData;

  const DailyLogCard({super.key, required this.payslipData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.payrollDetails,
          arguments: {"id": payslipData.id.toString() ?? "0"},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svgs/calendar.svg"),
                SizedBox(width: 4.w),
                Text(
                  payslipData.month!.toArabicDate(),
                  style: TextStyles.font18BlackSemiBold,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsManager.grey2,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 15.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Text(
                            S.of(context).Received,
                            style: TextStyles.font18lightBlackSemiBold,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            payslipData.netSalary.toString(),
                            style: TextStyles.font20BlackSemiBold,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            S.of(context).Paid_On,
                            style: TextStyles.font18lightBlackSemiBold,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            CacheHelper.getData(key: "app_lang") == "ar"
                                ? payslipData.period!
                                    .split("to")[1]
                                    .trim()
                                    .toArabicDate()
                                : payslipData.period!.split("to")[1].trim(),
                            style: TextStyles.font20BlackSemiBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
