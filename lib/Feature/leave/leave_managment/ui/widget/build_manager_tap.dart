import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';

class BuildManagerTap extends StatelessWidget {
  const BuildManagerTap({
    super.key,
    required this.title,
    required this.isSelected,
    required this.badgeCount,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final int badgeCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          decoration: BoxDecoration(
            color: isSelected ? ColorsManager.mainColor1 : Colors.white,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(20.r),
              left: Radius.circular(20.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyles.font16BlackNormal.copyWith(
                  color:
                      isSelected
                          ? ColorsManager.white
                          : ColorsManager.lightblack,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              SizedBox(width: 5.w),
              // if (badgeCount > 0)
              // Container(
              //   margin: EdgeInsets.only(top: 4.h),
              //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
              //   decoration: BoxDecoration(
              //     color: isSelected ? Colors.red : ColorsManager.grey3,
              //     borderRadius: BorderRadius.circular(12.r),
              //   ),
              //   child: Text(
              //     badgeCount.toString(),
              //     style: TextStyles.font16WhiteNormal,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
