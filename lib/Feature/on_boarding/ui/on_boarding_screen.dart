import 'package:flutter/material.dart';
import 'package:madarj/Feature/on_boarding/ui/widgets/on_boarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: OnBoardingBody(height: height),
    );
  }
}
