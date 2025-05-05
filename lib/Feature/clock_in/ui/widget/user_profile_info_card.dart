import 'package:flutter/material.dart';
import 'package:madarj/Feature/clock_in/ui/widget/user_avatar.dart';
import 'package:madarj/Feature/clock_in/ui/widget/user_profile_details.dart';
class UserProfileInfoCard extends StatelessWidget {
  const UserProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _cardPadding,
      child: Container(
        padding: _cardInnerPadding,
        decoration: _cardDecoration,
        child: const Row(
          children: [
            UserAvatar(radius: 30),
            SizedBox(width: 16),
            Expanded(child: UserProfileDetails()),
          ],
        ),
      ),
    );
  }

  EdgeInsets get _cardPadding => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      );

  EdgeInsets get _cardInnerPadding => const EdgeInsets.all(16);

  BoxDecoration get _cardDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFFEFEFE),
        boxShadow: [_cardShadow],
      );

  BoxShadow get _cardShadow => const BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(0, 2),
      );
}