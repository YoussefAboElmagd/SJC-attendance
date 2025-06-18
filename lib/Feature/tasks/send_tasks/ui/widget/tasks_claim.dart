import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class TasksClaim extends StatelessWidget {
  const TasksClaim({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).Attachment_text,
          style: TextStyles.font18BlackSemiBold,
        ),
        SizedBox(height: 4.h),
        Text(
          S.of(context).Format_should_MB,
          style: TextStyles.font14GreyRegular,
        ),
      ],
    );
  }
}
