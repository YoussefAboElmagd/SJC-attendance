import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
import 'package:madarj/Feature/home/logic/cubit/home_state.dart';
import 'package:madarj/Feature/home/ui/widgets/clock_in_screen_content.dart';
import 'package:flutter/services.dart';

import 'package:madarj/Feature/home/ui/widgets/home_top_icons.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorsManager.mainGray,
        body: const HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            const ClockInScreenContent(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
              child: const HomeTopIcons(),
            ),
          ],
        );
      },
    );
  }
}


// void setupLogout(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       actionsAlignment: MainAxisAlignment.spaceBetween,
//       // icon: const Icon(
//       //   Icons.error,
//       //   color: Colors.red,
//       //   size: 32,
//       // ),
//       content: Text(
//         S.of(context).logout_and_login_again,
//         style: TextStyles.font15DarkBlueMedium,
//       ),
//       actions: [
//         TextButton(
//           onPressed: () async {
//             context.pop();
//           },
//           child: Text(
//             S.of(context).no_continue_button,
//             style: TextStyles.font14BlueSemiBold,
//           ),
//         ),
//         // SizedBox(
//         //   width: MediaQuery.sizeOf(context).width * .5,
//         // ),
//         TextButton(
//           onPressed: () async {
//             // context.pop();
//             CachHelper.removeData(key: SharedKeys.userToken);
//             CachHelper.clearAllSecuredData();
//             context.pushNamedAndRemoveUntill(Routes.loginScreen);
//             AppConstants.isLogged = false;
//             await CachHelper.saveData(
//               key: SharedKeys.isLogged,
//               value: false,
//             );
//           },
//           child: Text(
//             S.of(context).logout_button,
//             style: TextStyles.font14BlueSemiBold,
//           ),
//         ),
//       ],
//     ),
//   );
// }
