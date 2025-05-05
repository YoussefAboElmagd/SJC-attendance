import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ClockInStatusBanner extends StatelessWidget {
  const ClockInStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _bannerPadding,
      child: Container(
        padding: _bannerInnerPadding,
        decoration: _bannerDecoration,
        child: Row(
          children: [
            _buildBannerText(),
            const SizedBox(width: 8),
            _buildBannerIcon(),
          ],
        ),
      ),
    );
  }

  EdgeInsets get _bannerPadding => const EdgeInsets.symmetric(horizontal: 16);

  EdgeInsets get _bannerInnerPadding => const EdgeInsets.all(16);

  BoxDecoration get _bannerDecoration => BoxDecoration(
        color: const Color(0xFF1E3A8A),
        borderRadius: BorderRadius.circular(12),
      );

  Widget _buildBannerText() {
    return const Expanded(
      child: Text(
        "You are in the clock-in area!\nNow you can press clock in in this area",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  Widget _buildBannerIcon() {
    return Align(
      alignment: Alignment.topRight,
      child: SvgPicture.asset(
        'assets/svgs/clock_with_wings.svg',
        height: 100.h,
      ),
    );
  }
}