import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveLogCard extends StatelessWidget {
  const LeaveLogCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.r,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svgs/magic-star.svg"),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "${DateTime.now().day} ${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().year}",
                  style: TextStyles.font14BlackSemiBold,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Leave_Date,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(
                            71,
                            84,
                            103,
                            1,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "11 Nov - 13 Nov",
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Total_Leave,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(
                            71,
                            84,
                            103,
                            1,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "2 Days",
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
