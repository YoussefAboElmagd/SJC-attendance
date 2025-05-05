import 'package:flutter/material.dart';


class UserAvatar extends StatelessWidget {
  final double radius;

  const UserAvatar({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: const AssetImage('assets/images/avatar1.png'),
    );
  }
}
