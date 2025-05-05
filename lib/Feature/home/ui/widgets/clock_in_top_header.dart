import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class ClockInTopHeader extends StatelessWidget {
  const ClockInTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 233.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.w),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(42, 49, 131, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    S.of(context).Lets_Clock_In,
                    style: TextStyles.font26WhiteBold,
                  ),
                  Text(
                    S.of(context).Dont_miss_your_clock_in_schedule,
                    // "Don’t miss your clock in schedule",
                    style: TextStyles.font14GreyRegular.copyWith(
                      color: const Color.fromRGBO(217, 214, 254, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w),
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  'assets/svgs/clock_with_wings.svg',
                  height: 90.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
