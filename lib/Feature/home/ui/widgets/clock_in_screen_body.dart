import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
import 'package:madarj/Feature/home/logic/cubit/home_state.dart';
import 'package:madarj/Feature/home/ui/widgets/clock_in_screen_content.dart';
// import 'package:flutter/services.dart';

import 'package:madarj/Feature/home/ui/widgets/home_top_icons.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pushNamed(Routes.cardsScreen);
        return true;
        // SystemNavigator.pop();
        // return false;
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
