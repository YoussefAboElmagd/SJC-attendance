import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2A3183),
            Color(0xFF1F1542),
            Color(0xFF1F1542),
            Color(0xFF1F1542),
            Color(0xFF1F1542),
          ],
          begin: Alignment.topRight,
          end: Alignment.center,
        ),
      ),
    );
  }
}
