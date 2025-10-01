import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';

class TaskAssignee extends StatelessWidget {
  const TaskAssignee({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Assignee', style: TextStyles.font14BlackSemiBold),
        SizedBox(height: 8.h),
        Row(
          children: [
            CircleAvatar(
              radius: 14.w,
              backgroundColor: Colors.transparent,
              backgroundImage:
                  const AssetImage("assets/images/test_person.jpg"),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alice', style: TextStyles.font14BlackSemiBold),
                Text('Sr Front End Developer',
                    style: TextStyles.font12lightBlackSemiBold),
              ],
            ),
          ],
        ),
      ],
    );
  }
}