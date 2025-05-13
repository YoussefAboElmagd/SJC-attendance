import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';

class StatusChips extends StatelessWidget {
  const StatusChips({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(
              20.r,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 16.w,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                'Done',
                style: TextStyles.font12GreenMedium,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 4.h,
          ),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(
              20.r,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.flag,
                color: Colors.red,
                size: 16.w,
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                'High',
                style: TextStyles.font12RedMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
