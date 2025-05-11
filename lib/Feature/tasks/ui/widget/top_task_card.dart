import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
class TopTaskCard extends StatelessWidget {
  const TopTaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.indigo,
          radius: 12.w,
          child: Icon(
            Icons.bolt,
            color: Colors.white,
            size: 16.w,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          'Wiring Dashboard Analytics',
          style: TextStyles.font16BlackSemiBold,
        ),
      ],
    );
  }
}
