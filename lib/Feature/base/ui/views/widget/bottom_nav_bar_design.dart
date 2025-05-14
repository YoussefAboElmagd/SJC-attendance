import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';

class BottomNavBarItemDesign extends StatelessWidget {
  const BottomNavBarItemDesign({
    super.key,
    required this.index,
    required this.currentIndex,
  });
  final int index;
  final int currentIndex;

  // Define the list of icons and names for the 5 items
  static const List<String> activeImagesBottomNavBar = [
    'assets/images/bottom_nav/home-se.png',
    // 'assets/images/bottom_nav/calendar-se.png',
    'assets/images/bottom_nav/expense-se.png',
    'assets/images/bottom_nav/receipt-se.png',
    'assets/images/bottom_nav/layer-se.png',
  ];
  static const List<String> inactiveImagesBottomNavBar = [
    'assets/images/bottom_nav/home-un.png',
    // 'assets/images/bottom_nav/calendar-un.png',
    'assets/images/bottom_nav/expense-un.png',
    'assets/images/bottom_nav/receipt-un.png',
    'assets/images/bottom_nav/layer-un.png',
  ];
  static const List<String> names = [
    // 'Home',
    'Attendant',
    'Task',
    'Expenses',
    'Leave',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          currentIndex == index
              ? activeImagesBottomNavBar[index]
              : inactiveImagesBottomNavBar[index],
          // width: 50.w,
          // height: 50.h,
        ),
        // currentIndex == index
        //     ?
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text(
            names[index],
            style: currentIndex == index
                ? TextStyles.font14WhiteSemiBold
                : TextStyles.font14GreyRegular,
          ),
        ),
        // : const SizedBox.shrink(),
        // currentIndex == index
        //     ? Padding(
        //         padding: EdgeInsets.only(top: 4.h),
        //         child: Text(
        //           names[index],
        //           style: TextStyles.font14WhiteSemiBold,
        //         ),
        //       )
        //     : const SizedBox.shrink(),
        currentIndex == index
            ? Container(
                width: 15.w,
                height: 2.h,
                margin: EdgeInsets.only(top: 4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  color: ColorsManager.white,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
