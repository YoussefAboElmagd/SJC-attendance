import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';

class WorkScheduleCard extends StatelessWidget {
  const WorkScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _cardPadding,
      child: Container(
        decoration: _cardDecoration,
        child: Padding(
          padding: _cardInnerPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 10),
              const _ScheduleTimesRow(),
            ],
          ),
        ),
      ),
    );
  }

  EdgeInsets get _cardPadding => const EdgeInsets.symmetric(horizontal: 16.0);

  BoxDecoration get _cardDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFFEFEFE),
        boxShadow: _cardShadows,
      );

  List<BoxShadow> get _cardShadows => const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, -2),
        )
      ];

  EdgeInsets get _cardInnerPadding => const EdgeInsets.all(8.0);

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Text(
        "Schedule",
        style: TextStyles.font14BlackSemiBold,
      ),
    );
  }
}

class _ScheduleTimesRow extends StatelessWidget {
  const _ScheduleTimesRow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          _ScheduleTimeItem(label: "CLOCK IN", time: "09:00"),
          SizedBox(
            width: 15,
          ),
          _ScheduleTimeItem(label: "CLOCK OUT", time: "05:00"),
        ],
      ),
    );
  }
}

class _ScheduleTimeItem extends StatelessWidget {
  final String label;
  final String time;

  const _ScheduleTimeItem({
    required this.label,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(
            Radius.circular(
              15.w,
            ),
          ),
          border: Border.all(
            color: Colors.grey[300]!,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0.h),
          child: Column(
            children: [
              Text(label, style: _labelStyle),
              const SizedBox(height: 4),
              Text(time, style: _timeStyle),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle get _labelStyle => const TextStyle(color: Colors.grey);

  TextStyle get _timeStyle => TextStyles.font17BlackBold;
}
