import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class OnboardingSubtitle extends StatelessWidget {
  const OnboardingSubtitle({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0.w),
      child: Text(
        S.of(context).on_borading_sub_title,
        textAlign: TextAlign.center,
        style: TextStyles.font16GreyNormal,
      ),
    );
  }
}
