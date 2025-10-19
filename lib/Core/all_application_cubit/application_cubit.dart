import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/cache_helper.dart';
import 'package:madarj/Core/helpers/lang_enum.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Feature/expenses/expenses_details/logic/cubit/expenses_cubit.dart';
import 'package:madarj/Feature/expenses/expenses_details/ui/expenses.dart';
import 'package:madarj/Feature/home/ui/home.dart';
import 'package:madarj/Feature/leave/leave_details/logic/cubit/leave_details_cubit.dart';
import 'package:madarj/Feature/leave/leave_details/ui/leave_screen.dart';
import 'package:madarj/Feature/tasks/tasks_details/ui/tasks.dart';

part 'application_cubit.freezed.dart';
// import 'package:ka3ba/Core/helpers/constants.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(const ApplicationState.initial());
  static ApplicationCubit get(context) => BlocProvider.of(context);
  String get lang =>
      CacheHelper.getData(key: SharedKeys.appLang) ?? LangEnum.ar.name;
  bool isArabic =
      CacheHelper.getData(key: SharedKeys.appLang) == LangEnum.ar.name ||
              CacheHelper.getData(key: SharedKeys.appLang) == null
          ? true
          : false;
  // static Locale locale = const Locale("ar");
  // String language = "ar";
  getLanguage(LangEnum language) {
    if (language == LangEnum.ar) {
      isArabic = true;
    } else {
      isArabic = false;
    }
    CacheHelper.saveData(value: language.name, key: SharedKeys.appLang);
    // language = language;
    emit(ApplicationState.changeTheLanguageOfApp(language: language.name));
  }

  int currentIndex = 0;
  void emitChangeBottomNav(int index) {
    currentIndex = index;
    emit(ApplicationState.changeBottomNav(index));
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
    // Container(),
    Container(),
    Container(),
    Container(),
  ];

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      // case 1:
      //   return Container();
      case 1:
        return const Tasks();
      case 2:
        return BlocProvider(
          create: (context) => getIt<ExpensesCubit>(),
          child: const Expenses(),
        );
      case 3:
        return BlocProvider(
          create: (context) => getIt<LeaveDetailsCubit>(),
          child: const Leave(),
        );
      default:
        return const HomeScreen();
    }
  }
}
