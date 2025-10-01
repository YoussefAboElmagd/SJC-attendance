import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';


class PriorityAndDifficulty extends StatelessWidget {
  const PriorityAndDifficulty({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Priority', style: TextStyles.font14BlackSemiBold),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: ColorsManager.highRed,
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
              child: Text('High', style: TextStyles.font14WhiteSemiBold),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Difficulty', style: TextStyles.font14BlackSemiBold),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text('Very Easy (Less Than a Day)',
                  style: TextStyles.font14BlackSemiBold),
            ),
          ],
        ),
      ],
    );
  }
}
