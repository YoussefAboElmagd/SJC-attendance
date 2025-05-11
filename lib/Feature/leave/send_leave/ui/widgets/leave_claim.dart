import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';


class LeaveClaim extends StatelessWidget {
  const LeaveClaim({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).Fill_Leave_Information,
          style: TextStyles.font18BlackSemiBold,
        ),
        SizedBox(height: 4.h),
        Text(
          S.of(context).Information_leave_details,
          style: TextStyles.font14GreyRegular,
        ),
      ],
    );
  }
}