import 'package:flutter/material.dart';
import 'package:madarj/Feature/clock_in/ui/widget/clockin_status_banner.dart';
import 'package:madarj/Feature/clock_in/ui/widget/work_schedule_card.dart';

import 'user_profile_info_card.dart';

class ClockInDetailsSection extends StatelessWidget {
  const ClockInDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClockInStatusBanner(),
        SizedBox(height: 10),
        UserProfileInfoCard(),
        SizedBox(height: 5),
        WorkScheduleCard(),
      ],
    );
  }
}