import 'package:flutter/material.dart';
import 'package:madarj/Feature/clock_in/ui/widget/user_profile_avatar.dart';

class PositionedAvatar extends StatelessWidget {
  const PositionedAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.sizeOf(context).height * .20 - 75,
      child: Container(
        height: 150,
        width: 150,
        decoration: _avatarContainerDecoration,
        child: const Center(
          child: UserProfileAvatar(radius: 35),
        ),
      ),
    );
  }

  BoxDecoration get _avatarContainerDecoration => BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue.withOpacity(0.5),
          width: 2,
        ),
      );
}
