import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/styles.dart';

class ShowButtomSheetForm extends StatelessWidget {
  const ShowButtomSheetForm({
    super.key,
    this.hint,
    this.icon,
    this.onTap,
  });
  final String? hint;
  final String? icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD0D5DD)),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            if (icon != null)
              SvgPicture.asset(
                icon!,
                width: 24.w,
                height: 24.h,
              ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                hint ?? '',
                style: TextStyles.font16GreyNormal,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 25.w,
            ),
          ],
        ),
      ),
    );
  }
}
