import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/widgets/custom_alert.dart';
import 'dart:math' as math;

class HomeTopIcons extends StatelessWidget {
  const HomeTopIcons({super.key, this.arrowColor});
  final Color? arrowColor;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            !ApplicationCubit.get(context).isArabic
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                        // setupLogout(context);
                      },
                      child: CircleAvatar(
                        radius: 17.w,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          width: 35.w,
                          "assets/images/arrow-back.png",
                          color: arrowColor ?? Colors.blue,
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      context.pop();
                      // setupLogout(context);
                    },
                    child: CircleAvatar(
                      radius: 17.w,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        width: 35.w,
                        "assets/images/arrow-back.png",
                        color: arrowColor ?? Colors.blue,
                      ),
                    ),
                  ),
            GestureDetector(
              onTap: () {
                context.pushNamed(Routes.language);
              },
              child: CircleAvatar(
                radius: 17.w,
                backgroundColor: Colors.white,
                child: SvgPicture.asset("assets/svgs/language2.svg"),
              ),
            ),
          ],
        );
      },
    );
  }
}

void setupLogout(BuildContext context) {
  showDialog(context: context, builder: (context) => const CustomAlert());
}
