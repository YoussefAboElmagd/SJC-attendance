import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveManagerTopHeader extends StatelessWidget {
  const LeaveManagerTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 235.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.w),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(42, 49, 131, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25.h),
                  Text(
                    S.of(context).time_off_managment,
                    style: TextStyles.font22WhiteBold,
                  ),
                  Text(
                    S.of(context).time_off_requests,
                    style: TextStyles.font14GreyRegular.copyWith(
                      color: const Color.fromRGBO(217, 214, 254, 1),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20.w),
              SizedBox(
                height: 150.h,
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/svgs/leave_header.svg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
