import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class OnboardingTitle extends StatelessWidget {
  const OnboardingTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.0.w),
      child: Text(
        S.of(context).on_borading_title,
        textAlign: TextAlign.center,
        style:  TextStyles.font16BlackSemiBold,
      ),
    );
  }
}
