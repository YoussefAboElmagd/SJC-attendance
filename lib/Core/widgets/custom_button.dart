import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.color,
    this.textStyle,
  });
  final String title;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Color? color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 45.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? ColorsManager.mainColor,
          borderRadius: BorderRadius.circular(10.r),
          border:
              color != null && color == ColorsManager.white
                  ? Border.all(color: ColorsManager.mainColor)
                  : null,
        ),
        child: Text(title, style: textStyle ?? TextStyles.font18WhiteBold),
      ),
    );
  }
}
