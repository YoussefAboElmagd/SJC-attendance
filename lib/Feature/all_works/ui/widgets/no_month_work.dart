import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:madarj/Core/themes/colors.dart';

class NoMonthWork extends StatelessWidget {
  const NoMonthWork({
    super.key,
    this.mainTitle,
    this.subTitle,
    this.secontTitle,
  });
  final String? mainTitle;
  final String? subTitle;
  final String? secontTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainTitle ?? S.of(context).month_Working_Period_text,
                    style: TextStyles.font14BlackSemiBold,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    subTitle ?? S.of(context).month_working_time_text,
                    style: TextStyles.font14CyranRegular.copyWith(
                      color: ColorsManager.gray,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0.w,
                  vertical: 15.0.h,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/svgs/no_work_today.svg",
                      width: 200.w,
                      height: 120.h,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      secontTitle ??
                          S.of(context).No_work_entries_available_text,
                      style: TextStyles.font16BlackSemiBold,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
