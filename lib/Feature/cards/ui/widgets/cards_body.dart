// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
// import 'package:madarj/Core/helpers/extensions.dart';
// import 'package:madarj/Core/routing/routes.dart';
// import 'package:madarj/Core/themes/colors.dart';
// import 'package:madarj/Core/themes/styles.dart';
// import 'package:madarj/Core/widgets/app_button.dart';
// import 'package:madarj/Feature/home/ui/widgets/home_top_icons.dart';
// import 'package:madarj/generated/l10n.dart';
// import 'dart:math' as math;

// class CardsBody extends StatelessWidget {
//   const CardsBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 100.h,
//           width: MediaQuery.sizeOf(context).width,
//           child: Container(
//             decoration: BoxDecoration(
//               color: ColorsManager.mainColor1,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(25.r),
//                 bottomRight: Radius.circular(25.r),
//               ),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 20.w,
//               ),
//               child: Row(
//                 children: [
//                   !ApplicationCubit.get(context).isArabic
//                       ? GestureDetector(
//                           onTap: () {
//                             setupLogout(context);
//                           },
//                           child: CircleAvatar(
//                             radius: 15.w,
//                             backgroundColor: Colors.white,
//                             child: Image.asset(
//                               width: 35.w,
//                               "assets/images/logout.png",
//                               color: Colors.red,
//                             ),
//                           ),
//                         )
//                       : Transform(
//                           alignment: Alignment.center,
//                           transform: Matrix4.rotationY(
//                             math.pi,
//                           ),
//                           child: GestureDetector(
//                             onTap: () {
//                               setupLogout(context);
//                             },
//                             child: CircleAvatar(
//                               // radius: 15.w,
//                               backgroundColor: Colors.white,
//                               child: Image.asset(
//                                 width: 35.w,
//                                 "assets/images/logout.png",
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ),
//                         ),
//                   const Spacer(),
//                   Text(
//                     S.of(context).home_text,
//                     style: TextStyles.font22WhiteBold,
//                   ),
//                   const Spacer(),
//                   GestureDetector(
//                     onTap: () {
//                       context.pushNamed(Routes.language);
//                     },
//                     child: CircleAvatar(
//                       radius: 17.w,
//                       backgroundColor: Colors.white,
//                       child: SvgPicture.asset(
//                         "assets/svgs/language2.svg",
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(
//             vertical: 60.h,
//             horizontal: 60.w,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AppTextButton(
//                 buttonHeight: 100.h,
//                 horizontalPadding: 15.h,
//                 verticalPadding: 15.h,
//                 buttonText:
//                     "${S.of(context).Clock_In} & ${S.of(context).Clock_Out} ",
//                 textStyle: TextStyles.font22WhiteBold,
//                 onPressed: () {
//                   context.pushNamed(Routes.baseLayer, arguments: 0);
//                 },
//                 backgroundColor: ColorsManager.mainColor1,
//                 hintText: "hintText",
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//               AppTextButton(
//                 backgroundColor: ColorsManager.mainColor1,
//                 buttonHeight: 100.h,
//                 horizontalPadding: 15.h,
//                 verticalPadding: 15.h,
//                 buttonText: S.of(context).Submit_Expense,
//                 textStyle: TextStyles.font22WhiteBold,
//                 onPressed: () {
//                   context.pushNamed(Routes.baseLayer, arguments: 3);
//                 },
//                 hintText: "hintText",
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//               AppTextButton(
//                 backgroundColor: ColorsManager.mainColor1,
//                 buttonHeight: 100.h,
//                 horizontalPadding: 15.h,
//                 verticalPadding: 15.h,
//                 buttonText: S.of(context).Submit_Leave_text,
//                 textStyle: TextStyles.font22WhiteBold,
//                 onPressed: () {
//                   context.pushNamed(Routes.baseLayer, arguments: 4);
//                 },
//                 hintText: "hintText",
//               ),
//               SizedBox(
//                 height: 30.h,
//               ),
//               AppTextButton(
//                 backgroundColor: ColorsManager.mainColor1,
//                 buttonHeight: 100.h,
//                 horizontalPadding: 15.h,
//                 verticalPadding: 15.h,
//                 buttonText: "buttonText",
//                 textStyle: TextStyles.font22WhiteBold,
//                 onPressed: () {
//                   context.pushNamed(Routes.baseLayer);
//                 },
//                 hintText: "hintText",
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
// import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Feature/home/ui/widgets/home_top_icons.dart';
import 'package:madarj/generated/l10n.dart';
import 'dart:math' as math;

class CardsBody extends StatelessWidget {
  CardsBody({super.key});
  final List<String> images = [
    'assets/images/bottom_nav/home-se.png',
    'assets/images/bottom_nav/calendar-se.png',
    'assets/images/bottom_nav/expense-se.png',
    'assets/images/bottom_nav/receipt-se.png',
  ];
  final List<String> texts = [
    'Home',
    'Tasks',
    'expense',
    'Leave',
  ];
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: index % 2 == 0
                          ? const BorderSide(
                              color: Colors.grey,
                              width: 2,
                            )
                          : BorderSide.none,
                      bottom: index < 2
                          ? const BorderSide(
                              color: Colors.grey,
                              width: 2,
                            )
                          : BorderSide.none,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CardsWidget(
                        image: images[index],
                        title: texts[index],
                        screen: index,
                      ),
                    ),
                  ),
                );
              },
            ),
            // GridView.builder(
            //   shrinkWrap: true,
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 10,
            //     crossAxisSpacing: 10,
            //   ),
            //   itemCount: 4,
            //   itemBuilder: (context, index) {
            //     return CardsWidget(
            //       image: images[index],
            //       title: texts[index],
            //     );
            //   },
            // )
            // AppTextButton(
            //   buttonHeight: 100.h,
            //   horizontalPadding: 15.h,
            //   verticalPadding: 15.h,
            //   buttonText:
            //       "${S.of(context).Clock_In} & ${S.of(context).Clock_Out} ",
            //   textStyle: TextStyles.font22WhiteBold,
            //   onPressed: () {
            //     context.pushNamed(Routes.baseLayer, arguments: 0);
            //   },
            //   backgroundColor: ColorsManager.mainColor1,
            //   hintText: "hintText",
            // ),
            // SizedBox(
            //   height: 30.h,
            // ),
            // AppTextButton(
            //   backgroundColor: ColorsManager.mainColor1,
            //   buttonHeight: 100.h,
            //   horizontalPadding: 15.h,
            //   verticalPadding: 15.h,
            //   buttonText: S.of(context).Submit_Expense,
            //   textStyle: TextStyles.font22WhiteBold,
            //   onPressed: () {
            //     context.pushNamed(Routes.baseLayer, arguments: 3);
            //   },
            //   hintText: "hintText",
            // ),
            // SizedBox(
            //   height: 30.h,
            // ),
            // AppTextButton(
            //   backgroundColor: ColorsManager.mainColor1,
            //   buttonHeight: 100.h,
            //   horizontalPadding: 15.h,
            //   verticalPadding: 15.h,
            //   buttonText: S.of(context).Submit_Leave_text,
            //   textStyle: TextStyles.font22WhiteBold,
            //   onPressed: () {
            //     context.pushNamed(Routes.baseLayer, arguments: 4);
            //   },
            //   hintText: "hintText",
            // ),
            // SizedBox(
            //   height: 30.h,
            // ),
            // AppTextButton(
            //   backgroundColor: ColorsManager.mainColor1,
            //   buttonHeight: 100.h,
            //   horizontalPadding: 15.h,
            //   verticalPadding: 15.h,
            //   buttonText: "buttonText",
            //   textStyle: TextStyles.font22WhiteBold,
            //   onPressed: () {
            //     context.pushNamed(Routes.baseLayer);
            //   },
            //   hintText: "hintText",
            // ),
          ],
        ),
      ],
    );
  }
}

class CardsWidget extends StatelessWidget {
  const CardsWidget({
    super.key,
    required this.image,
    required this.title,
    required this.screen,
  });

  final String image;
  final String title;
  final int screen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.baseLayer, arguments: screen);
        // print(context.pushNamed(Routes.baseLayer, arguments: 4);)
      },
      child: Container(
        child: Column(
          children: [
            Image(
              // width: 80.w,
              height: 50.h,
              color: ColorsManager.mainColor1,
              fit: BoxFit.fill,
              image: AssetImage(
                image,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              title,
              style: TextStyles.font16BlackSemiBold,
            ),
          ],
        ),
      ),
    );
  }
}
