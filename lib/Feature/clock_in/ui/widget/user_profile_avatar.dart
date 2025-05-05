import 'package:flutter/material.dart';

class UserProfileAvatar extends StatelessWidget {
  final double radius;

  const UserProfileAvatar({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: const AssetImage('assets/images/avatar1.png'),
    );
  }
}
