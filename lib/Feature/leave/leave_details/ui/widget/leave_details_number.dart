import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveDetailsNumber extends StatelessWidget {
  const LeaveDetailsNumber({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.widget,
  });
  final String? image;
  final String? title;
  final String? price;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.r,
        ),
        border: Border.all(
          color: ColorsManager.lighterGray,
          width: 1.w,
        ),
        color: ColorsManager.grey2,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: 22.w,
          left: 12.h,
          top: 15.h,
          bottom: 13.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget ?? Container(),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  title ?? S.of(context).Total_text,
                  style: TextStyles.font16lightBlackSemiBold,
                ),
              ],
            ),
            SizedBox(
              height: 10.w,
            ),
            Text(
              price ?? "200",
              style: TextStyles.font20BlackBold,
            ),
          ],
        ),
      ),
    );
  }
}
