import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';


class TaskHeader extends StatelessWidget {
  const TaskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Create On Boarding Screen',
            style: TextStyles.font16BlackSemiBold),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: ColorsManager.mainColor1,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(S.of(context).In_Progress_text,
              style: TextStyles.font14WhiteSemiBold),
        ),
      ],
    );
  }
}