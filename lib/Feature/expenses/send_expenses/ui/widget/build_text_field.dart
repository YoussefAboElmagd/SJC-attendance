import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_text_formField.dart';
class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    this.label,
    this.hint,
    this.icon,
    this.maxLines,
  });
  final String? label;
  final String? hint;
  final String? icon;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: TextStyles.font14BlackSemiBold,
        ),
        SizedBox(height: 8.h),
        AppTextFormField(
          maxLines: maxLines,
          hintText: hint!,
          hintStyle: TextStyles.font14GreyRegular,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          prefixIcon: icon != null
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 11.w,
                    vertical: 11.h,
                  ),
                  child: SvgPicture.asset(
                    icon!,
                  ),
                )
              : null,
          backgroundColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: Color(
                0xFFD0D5DD,
              ),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: Colors.deepPurple,
            ),
          ),
        )
      ],
    );
  }
}