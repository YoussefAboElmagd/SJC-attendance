// import 'package:flutter/material.dart';

// class AdeminBottomNavigationBarItemButton extends StatelessWidget {
//   const AdeminBottomNavigationBarItemButton({super.key, required this.cubit});
//   final UiCubit cubit;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             if (cubit.currentIndexAdmin == 0) {
//               final currentNavigatorState = cubit
//                   .navigatorKeysAdmin[cubit.currentIndexAdmin].currentState;
//               if (currentNavigatorState != null &&
//                   currentNavigatorState.canPop()) {
//                 currentNavigatorState.popUntil((route) => route.isFirst);
//               }
//             } else {
//               cubit.emitChangeBottomNavAdmin(0);
//             }
//           },
//           child: BottomNavBarItemDesign(
//             index: 0,
//             currentIndex: cubit.currentIndexAdmin,
//           ),
//         ),
//         GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             if (cubit.currentIndexAdmin == 1) {
//               final currentNavigatorState = cubit
//                   .navigatorKeysAdmin[cubit.currentIndexAdmin].currentState;
//               if (currentNavigatorState != null &&
//                   currentNavigatorState.canPop()) {
//                 currentNavigatorState.popUntil((route) => route.isFirst);
//               }
//             } else {
//               cubit.emitChangeBottomNavAdmin(1);
//             }
//           },
//           child: BottomNavBarItemDesign(
//             index: 1,
//             currentIndex: cubit.currentIndexAdmin,
//           ),
//         ),
//         GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             if (cubit.currentIndexAdmin == 2) {
//               final currentNavigatorState = cubit
//                   .navigatorKeysAdmin[cubit.currentIndexAdmin].currentState;
//               if (currentNavigatorState != null &&
//                   currentNavigatorState.canPop()) {
//                 currentNavigatorState.popUntil((route) => route.isFirst);
//               }
//             } else {
//               cubit.emitChangeBottomNavAdmin(2);
//             }
//           },
//           child: AdditionNavBarItemDesign(
//             index: 2,
//             currentIndex: cubit.currentIndexAdmin,
//           )
//               .animate(
//                 onPlay: (controller) => controller.repeat(),
//               )
//               .rotate(
//                 delay: const Duration(milliseconds: 1000),
//                 duration: 700.ms,
//                 curve: Curves.linear,
//               ),
//         ),
//         GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             if (cubit.currentIndexAdmin == 3) {
//               final currentNavigatorState = cubit
//                   .navigatorKeysAdmin[cubit.currentIndexAdmin].currentState;
//               if (currentNavigatorState != null &&
//                   currentNavigatorState.canPop()) {
//                 currentNavigatorState.popUntil((route) => route.isFirst);
//               }
//             } else {
//               cubit.emitChangeBottomNavAdmin(3);
//             }
//           },
//           child: BottomNavBarItemDesign(
//             index: 3,
//             currentIndex: cubit.currentIndexAdmin,
//           ),
//         ),
//         GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             if (cubit.currentIndexAdmin == 4) {
//               final currentNavigatorState = cubit
//                   .navigatorKeysAdmin[cubit.currentIndexAdmin].currentState;
//               if (currentNavigatorState != null &&
//                   currentNavigatorState.canPop()) {
//                 currentNavigatorState.popUntil((route) => route.isFirst);
//               }
//             } else {
//               cubit.emitChangeBottomNavAdmin(4);
//             }
//           },
//           child: BottomNavBarItemDesign(
//             index: 4,
//             currentIndex: cubit.currentIndexAdmin,
//           ),
//         ),
//       ],
//     );
//   }
// }
