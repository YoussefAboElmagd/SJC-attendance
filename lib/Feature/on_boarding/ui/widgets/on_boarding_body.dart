import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/on_boarding/ui/widgets/bottom_items.dart';
import 'package:madarj/Feature/on_boarding/ui/widgets/logo_section.dart';
import 'package:madarj/Feature/on_boarding/ui/widgets/on_boarding_background.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const OnboardingBackground(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(flex: 2, child: LogoSection()),
            SizedBox(height: 40.h),
            Expanded(child: BottomItems(height: height)),
            SizedBox(height: 30.h),
          ],
        ),
      ],
    );
  }
}
