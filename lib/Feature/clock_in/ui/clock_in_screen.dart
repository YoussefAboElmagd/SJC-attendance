import 'package:flutter/material.dart';
import 'package:madarj/Feature/clock_in/ui/widget/clock_in_components.dart';
import 'package:madarj/Feature/clock_in/ui/widget/clock_in_details_section.dart';
import 'package:madarj/Feature/clock_in/ui/widget/map_with_user_avatar.dart';

class ClockInScreen extends StatelessWidget {
  const ClockInScreen({super.key, this.lat, this.long});
  final double? lat;
  final double? long;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: ClockInActionButton(lat: lat, long: long),
      body: Column(
        children: [
          const MapWithUserAvatar(),
          Expanded(
            child: Container(
              decoration: _bottomSheetDecoration,
              child: const ClockInDetailsSection(),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration get _bottomSheetDecoration => const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            25,
          ),
        ),
        color: Colors.white,
      );
}
