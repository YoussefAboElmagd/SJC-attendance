import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class NoAttendanceToday extends StatelessWidget {
  const NoAttendanceToday({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 10.h,
            right: 5.w,
            left: 5.w,
          ),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 12.0.h, right: 12.0.w, left: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).refused_attendance,
                      style: TextStyles.font14BlackSemiBold,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      S.of(context).follow_refused_attendance,
                      style: TextStyles.font14CyranRegular.copyWith(
                        color: ColorsManager.gray,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.h, right: 50.w, left: 50.w),
                  child: Center(
                    child: Image.asset(
                      "assets/images/cards/attendance.png",
                      height: 100.h,
                      width: 100.h,
                      color: ColorsManager.mainColor1,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).no_refused_requests,
                      style: TextStyles.font14BlackSemiBold,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 8.w,
                      ),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          S.of(context).no_refused_requests_description,
                          style: TextStyles.font10GreyRegular,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
