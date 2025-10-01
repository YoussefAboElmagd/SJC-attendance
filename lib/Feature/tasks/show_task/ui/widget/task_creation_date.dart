import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';


class TaskCreationDate extends StatelessWidget {
  const TaskCreationDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Created 27 Sept 2024',
        style: TextStyles.font12lightBlackSemiBold);
  }
}

class TaskDescription extends StatelessWidget {
  const TaskDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: TextStyles.font14BlackSemiBold),
        SizedBox(height: 4.h),
        Text(
          'Create on boarding page based on pic, pixel perfect, with the user story of i want to know what kind of apps is this...',
          style: TextStyles.font14GreySemiBold,
        ),
      ],
    );
  }
}