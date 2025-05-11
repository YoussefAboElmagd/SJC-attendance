import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';

class BurnoutStatsCard extends StatelessWidget {
  const BurnoutStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12.r,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 17.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Sprint 20 - Burnout Stats',
                  style: TextStyles.font16BlackSemiBold,
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                  ),
                  child: Text(
                    'Poor',
                    style: TextStyles.font12OrangeBold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            RichText(
              text: TextSpan(
                style: TextStyles.font14BlackSemiBold,
                children: const [
                  TextSpan(
                    text: 'You’ve completed ',
                  ),
                  TextSpan(
                    text: '8 more tasks than usual',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ', maintain your task with your supervisor',
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(
                  12.r,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    '☹️',
                    style: TextStyles.font20BlackBold,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.85,
                          child: Container(
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(
                                4.r,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}