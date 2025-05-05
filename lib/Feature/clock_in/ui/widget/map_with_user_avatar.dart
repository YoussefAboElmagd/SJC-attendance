import 'package:flutter/material.dart';
import 'package:madarj/Feature/clock_in/ui/widget/clockin_appbar.dart';
import 'package:madarj/Feature/clock_in/ui/widget/positioned_avatar.dart';

class MapWithUserAvatar extends StatelessWidget {
  const MapWithUserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .40,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              _buildMapBackground(),
              const PositionedAvatar(),
            ],
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * .000001,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: const ClockInAppBar(
                title: "Clock In Area",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapBackground() {
    return Image.asset(
      'assets/images/map_placeholder.png',
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
}
