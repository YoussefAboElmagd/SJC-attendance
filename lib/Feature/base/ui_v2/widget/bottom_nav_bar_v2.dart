import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/base/ui_v2/widget/bottom_navigation_bar_item_button_v2.dart';

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
      height: MediaQuery.sizeOf(context).height * 0.08,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: ColorsManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorsManager.grey.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
            child: BottomNavigationBarItemButton(cubit: cubit),

      // child: CachHelper.getData(key: 'role') == 'admin'
      //     ? AdeminBottomNavigationBarItemButton(cubit: cubit)
      //     : BottomNavigationBarItemButton(cubit: cubit),
    );
  }
}
