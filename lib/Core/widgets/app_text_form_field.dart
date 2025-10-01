import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final TextStyle? helperStyle;
  final String hintText;
  final String? helperText;

  final bool? isObscureText;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final int? maxLines;
  final Function(String?)? validator;
  final TextInputType? keyboardType;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.controller,
    this.validator,
    this.keyboardType,
    this.readOnly,
    this.helperText,
    this.helperStyle,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      controller: controller,
      validator: (value) {
        return validator!(value);
      },
      decoration: InputDecoration(
        isDense: true,
        helperText: helperText,
        helperStyle: helperStyle ?? TextStyles.font11WhiteRegular,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              vertical: 18.h,
              horizontal: 20.w,
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.mainColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.mainColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintStyle: hintStyle ?? TextStyles.font18BlackBold,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: backgroundColor ?? ColorsManager.moreLightGray,
        filled: true,
      ),
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: isObscureText ?? false,
      autofocus: false,
      style: inputTextStyle ?? TextStyles.font18BlackBold,
    );
  }
}
