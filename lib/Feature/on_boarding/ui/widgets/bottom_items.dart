import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/on_boarding/ui/widgets/onboarding_subtitle.dart';
import 'package:madarj/Feature/on_boarding/ui/widgets/onboarding_title.dart';
import 'package:madarj/Feature/on_boarding/ui/widgets/sign_in_button.dart';

class BottomItems extends StatelessWidget {
  const BottomItems({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 32.h,
          right: 32.w,
          left: 32.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const OnboardingTitle(),
            SizedBox(height: 15.h),
            OnboardingSubtitle(height: height),
            SizedBox(height: 15.h),
            const SignInButton(),
          ],
        ),
      ),
    );
  }
}
