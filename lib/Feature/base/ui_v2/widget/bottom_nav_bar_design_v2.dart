import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';

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
    'assets/images/bottom_nav/calendar-se.png',
    'assets/images/bottom_nav/expense-se.png',
    'assets/images/bottom_nav/receipt-se.png',
    'assets/images/bottom_nav/layer-se.png',
  ];
  static const List<String> inactiveImagesBottomNavBar = [
    'assets/images/bottom_nav/home-un.png',
    'assets/images/bottom_nav/calendar-un.png',
    'assets/images/bottom_nav/expense-un.png',
    'assets/images/bottom_nav/receipt-un.png',
    'assets/images/bottom_nav/layer-un.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(
            activeImagesBottomNavBar[index],
            // CachHelper.getData(key: 'role') == 'admin'
            //     ? imagesBottomNavBarAdmin[index]
            //     : imagesBottomNavBarStudent[index],
            width: currentIndex == index ? 33.w : 25.w,
            height: currentIndex == index ? 33.w : 25.w,
            color: currentIndex == index
                ? ColorsManager.mainColor
                : ColorsManager.grey,
          ),
        ),
        currentIndex == index
            ? Container(
                width: 30.w,
                height: 3.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: ColorsManager.mainColor,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

// class AdditionNavBarItemDesign extends StatelessWidget {
//   const AdditionNavBarItemDesign({
//     super.key,
//     required this.index,
//     required this.currentIndex,
//   });
//   final int index;
//   final int currentIndex;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: Container(
//             width: 45.w,
//             height: 45.h,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: ColorsManager.mainColor,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: ColorsManager.grey.withOpacity(0.5),
//                   blurRadius: 10,
//                   spreadRadius: 1,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Image.asset(
//               Assets.assetsImagesPlus,
//               width: 25.w,
//               color: ColorsManager.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
