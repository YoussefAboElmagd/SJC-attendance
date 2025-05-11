import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Feature/home/ui/widgets/home_top_icons.dart';
import 'package:madarj/generated/l10n.dart';
import 'dart:math' as math;

class CardsBody extends StatelessWidget {
  const CardsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100.h,
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
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Row(
                children: [
                  !ApplicationCubit.get(context).isArabic
                      ? GestureDetector(
                          onTap: () {
                            setupLogout(context);
                          },
                          child: CircleAvatar(
                            radius: 15.w,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              width: 35.w,
                              "assets/images/logout.png",
                              color: Colors.red,
                            ),
                          ),
                        )
                      : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(
                            math.pi,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setupLogout(context);
                            },
                            child: CircleAvatar(
                              // radius: 15.w,
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                width: 35.w,
                                "assets/images/logout.png",
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                  const Spacer(),
                  Text(
                    S.of(context).home_text,
                    style: TextStyles.font22WhiteBold,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.language);
                    },
                    child: CircleAvatar(
                      radius: 17.w,
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset(
                        "assets/svgs/language2.svg",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 60.h,
            horizontal: 60.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextButton(
                buttonHeight: 100.h,
                horizontalPadding: 15.h,
                verticalPadding: 15.h,
                buttonText:
                    "${S.of(context).Clock_In} & ${S.of(context).Clock_Out} ",
                textStyle: TextStyles.font22WhiteBold,
                onPressed: () {
                  context.pushNamed(Routes.baseLayer, arguments: 0);
                },
                backgroundColor: ColorsManager.mainColor1,
                hintText: "hintText",
              ),
              SizedBox(
                height: 30.h,
              ),
              AppTextButton(
                backgroundColor: ColorsManager.mainColor1,
                buttonHeight: 100.h,
                horizontalPadding: 15.h,
                verticalPadding: 15.h,
                buttonText: S.of(context).Submit_Expense,
                textStyle: TextStyles.font22WhiteBold,
                onPressed: () {
                  context.pushNamed(Routes.baseLayer, arguments: 3);
                },
                hintText: "hintText",
              ),
              SizedBox(
                height: 30.h,
              ),
              AppTextButton(
                backgroundColor: ColorsManager.mainColor1,
                buttonHeight: 100.h,
                horizontalPadding: 15.h,
                verticalPadding: 15.h,
                buttonText: S.of(context).Submit_Leave_text,
                textStyle: TextStyles.font22WhiteBold,
                onPressed: () {
                  context.pushNamed(Routes.baseLayer, arguments: 4);
                },
                hintText: "hintText",
              ),
              SizedBox(
                height: 30.h,
              ),
              AppTextButton(
                backgroundColor: ColorsManager.mainColor1,
                buttonHeight: 100.h,
                horizontalPadding: 15.h,
                verticalPadding: 15.h,
                buttonText: "buttonText",
                textStyle: TextStyles.font22WhiteBold,
                onPressed: () {
                  context.pushNamed(Routes.baseLayer);
                },
                hintText: "hintText",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
