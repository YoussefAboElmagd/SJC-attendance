import 'package:flutter/material.dart';

class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFEEF0FB),
            Color(0xFFE7E9F6),
            Color(0xFFE1E3F3),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Image.asset(
        'assets/images/laptop_background.png',
        width: MediaQuery.sizeOf(context).width,
        fit: BoxFit.fill,
      ),
    );
  }
}
