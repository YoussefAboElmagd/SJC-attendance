import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';

class AppTextButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  final Widget? appendItem;
  final TextAlign? textAlign;

  const AppTextButton({
    super.key,
    this.appendItem,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
    this.textAlign,
    required String hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 24.0),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? ColorsManager.mainBlue,
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding?.w ?? 12.w,
            vertical: verticalPadding?.h ?? 12.h,
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(buttonWidth?.w ?? double.maxFinite, buttonHeight ?? 50.h),
        ),
        overlayColor: WidgetStateProperty.all<Color>(
          Colors.transparent,
        ), // No hover color
        mouseCursor: WidgetStateProperty.all<MouseCursor>(MouseCursor.defer),
      ),
      onPressed: onPressed,
      child: buttonText == ""
          ? appendItem!
          : appendItem != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: textAlign,
                      buttonText,
                      style: textStyle,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    appendItem!
                  ],
                )
              : Text(
                  textAlign: textAlign,
                  buttonText,
                  style: textStyle,
                ),
    );
  }
}
