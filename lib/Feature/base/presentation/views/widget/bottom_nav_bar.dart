import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/base/presentation/views/widget/bottom_navigation_bar_item_button.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.cubit,
  });

  final ApplicationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: AlignmentDirectional.center,
      height: MediaQuery.sizeOf(context).height * 0.1,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            26.r,
          ),
          topLeft: Radius.circular(
            26.r,
          ),
        ),
        gradient: LinearGradient(
          colors: [
            ColorsManager.mainColor1.withBlue(100),
            ColorsManager.mainColor5,
            ColorsManager.mainColor5,
            ColorsManager.mainColor5,
            ColorsManager.mainColor5,
            ColorsManager.mainColor5,
            ColorsManager.mainColor5,
            ColorsManager.mainColor5,
            // ColorsManager.mainColor1,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        // color: Colors.white,
      ),
      child: BottomNavigationBarItemButton(cubit: cubit),
    );
  }
}
