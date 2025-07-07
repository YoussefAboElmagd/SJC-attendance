import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/home/ui/widgets/home_top_icons.dart';
import 'package:madarj/generated/l10n.dart';
import 'dart:math' as math;

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = ApplicationCubit.get(context).isArabic;

    return SizedBox(
      height: 130.h,
      width: MediaQuery.sizeOf(context).width,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.mainColor1,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.r),
            bottomRight: Radius.circular(25.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setupLogout(context),
                child: isArabic
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: _buildLogoutIcon(),
                      )
                    : _buildLogoutIcon(),
              ),
              const Spacer(),
              Text(S.of(context).home_text, style: TextStyles.font22WhiteBold),
              const Spacer(),
              GestureDetector(
                onTap: () => context.pushNamed(Routes.language),
                child: CircleAvatar(
                  radius: 23.w,
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    "assets/svgs/language2.svg",
                    height: 45.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutIcon() {
    return CircleAvatar(
      radius: 23.w,
      backgroundColor: Colors.white,
      child: Image.asset(
        "assets/images/logout.png",
        width: 45.w,
        color: Colors.red,
      ),
    );
  }
}
