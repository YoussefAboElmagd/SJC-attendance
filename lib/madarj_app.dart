import 'package:flutter/material.dart';
// import 'package:flutter_offline/flutter_offline.dart';
// import 'package:labaiik_mo3tmer/Core/all_application_cubit/application_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/routing/app_routes.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/generated/l10n.dart';

class MadarjApp extends StatefulWidget {
  const MadarjApp({super.key});

  @override
  State<MadarjApp> createState() => LlabaiiMmo3tmerState();
}

class LlabaiiMmo3tmerState extends State<MadarjApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 882),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) => getIt<ApplicationCubit>(),
        child: BlocBuilder<ApplicationCubit, ApplicationState>(
          builder: (context, state) {
            String language = CachHelper.getData(key: "app_lang") ?? "en";

            if (state is ChangeTheLanguageOfApp) {
              language = state.language;
            }
            print(language);
            print(language);
            return MaterialApp(
              locale: Locale(language),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              title: "Attendance",
              theme: ThemeData(
                primaryColor: ColorsManager.mainBlue,
                scaffoldBackgroundColor: Colors.white,
              ),
              debugShowCheckedModeBanner: false,
              // initialRoute: Routes.cardsScreen,
              initialRoute: AppConstants.isLogged
                  ? Routes.
                  : Routes.onBoardingScreen,
              onGenerateRoute: AppRouter().generateRoute,
            );
          },
        ),
      ),
    );
  }
}
