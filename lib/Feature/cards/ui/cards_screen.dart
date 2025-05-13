import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
// import 'package:madarj/Core/helpers/extensions.dart';
// import 'package:madarj/Core/routing/routes.dart';
// import 'package:madarj/Core/themes/colors.dart';
// import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/cards/ui/widgets/cards_body.dart';
// import 'package:madarj/Feature/home/ui/widgets/home_top_icons.dart';
// import 'package:madarj/generated/l10n.dart';
// import 'dart:math' as math;

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child:  Scaffold(
        // appBar: AppBar(
        //   leading: !ApplicationCubit.get(context).isArabic
        //       ? GestureDetector(
        //           onTap: () {
        //             setupLogout(context);
        //           },
        //           child: CircleAvatar(
        //             radius: 15.w, // unchanged
        //             backgroundColor: Colors.white,
        //             child: SizedBox(
        //               width: 20.w,
        //               height: 20.w,
        //               child: Image.asset(
        //                 "assets/images/logout.png",
        //                 color: Colors.red,
        //                 fit: BoxFit.contain,
        //               ),
        //             ),
        //           ),
        //         )
        //       : Transform(
        //           alignment: Alignment.center,
        //           transform: Matrix4.rotationY(math.pi),
        //           child: GestureDetector(
        //             onTap: () {
        //               setupLogout(context);
        //             },
        //             child: CircleAvatar(
        //               radius: 15.w, // unchanged
        //               backgroundColor: Colors.white,
        //               child: SizedBox(
        //                 width: 20.w,
        //                 height: 20.w,
        //                 child: Image.asset(
        //                   "assets/images/logout.png",
        //                   color: Colors.red,
        //                   fit: BoxFit.contain,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),

        //   // leading: !ApplicationCubit.get(context).isArabic
        //   //     ? GestureDetector(
        //   //         onTap: () {
        //   //           setupLogout(context);
        //   //         },
        //   //         child: CircleAvatar(
        //   //           radius: 15.w,
        //   //           backgroundColor: Colors.white,
        //   //           child: Image.asset(
        //   //             width: 35.w,
        //   //             "assets/images/logout.png",
        //   //             color: Colors.red,
        //   //           ),
        //   //         ),
        //   //       )
        //   //     : Transform(
        //   //         alignment: Alignment.center,
        //   //         transform: Matrix4.rotationY(
        //   //           math.pi,
        //   //         ),
        //   //         child: GestureDetector(
        //   //           onTap: () {
        //   //             setupLogout(context);
        //   //           },
        //   //           child: CircleAvatar(
        //   //             // radius: 15.w,
        //   //             backgroundColor: Colors.white,
        //   //             child: Image.asset(
        //   //               width: 35.w,
        //   //               "assets/images/logout.png",
        //   //               color: Colors.red,
        //   //             ),
        //   //           ),
        //   //         ),
        //   //       ),
        //   title: Text(
        //     S.of(context).home_text,
        //     style: TextStyles.font22WhiteBold,
        //   ),
        //   actions: [
        //     GestureDetector(
        //       onTap: () {
        //         context.pushNamed(Routes.language);
        //       },
        //       child: CircleAvatar(
        //         radius: 17.w,
        //         backgroundColor: Colors.white,
        //         child: SvgPicture.asset(
        //           "assets/svgs/language2.svg",
        //         ),
        //       ),
        //     ),
        //   ],
        //   centerTitle: true,
        //   backgroundColor: ColorsManager.mainColor1,
        // ),
        body: CardsBody(),
      ),
    );
  }
}
