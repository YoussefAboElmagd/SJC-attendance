// import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Feature/expenses/expnses_details/logic/cubit/expenses_cubit.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/expenses.dart';
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
// import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Feature/home/ui/home.dart';
import 'package:madarj/Feature/leave/leave_details/ui/leave_screen.dart';
import 'package:madarj/Feature/tasks/ui/tasks.dart';

// import 'package:ka3ba/Core/helpers/constants.dart';

part 'application_state.dart';
part 'application_cubit.freezed.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(const ApplicationState.initial());
  static ApplicationCubit get(context) => BlocProvider.of(context);

  bool isArabic = CachHelper.getData(key: "app_lang") == "ar" ? true : false;
  static Locale locale = const Locale("en");
  String language = "en";
  getlanguage(String language) {
    if (language == "ar") {
      // AppConstants.isArabic = true;
      isArabic = true;
      CachHelper.saveData(value: "ar", key: "app_lang");
    } else {
      // AppConstants.isArabic = false;
      isArabic = false;
      CachHelper.saveData(value: "en", key: "app_lang");
    }
    language = language;
    // print("AppConstants ${AppConstants.isArabic}");
    // print("cubit ${isArabic}");
    emit(ApplicationState.changeTheLanguageOfApp(language: language));
  }

  int currentIndex = 0;
  void emitChangeBottomNav(int index) {
    currentIndex = index;
    emit(
      ApplicationState.changeBottomNav(
        index,
      ),
    );
  }

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  List<Widget> get pages => [
        const HomeScreen(),
        Container(),
        Container(),
        Container(),
        Container(),
      ];

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return Container();
      case 2:
        return const Tasks();
      case 3:
        return BlocProvider(
          create: (context) => getIt<ExpensesCubit>(),
          child: const Expenses(),
        );
      case 4:
        return const Leave();
      default:
        return Container();
    }
  }
}
