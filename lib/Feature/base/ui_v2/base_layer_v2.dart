// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/routing/app_routes.dart';
import 'package:madarj/Feature/base/ui_v2/widget/bottom_nav_bar_v2.dart';

class BaseLayer2 extends StatelessWidget {
  const BaseLayer2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        var cubit = ApplicationCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            return !await cubit.navigatorKeys[cubit.currentIndex].currentState!
                .maybePop();
            // return !await CachHelper.getData(key: 'role') == 'admin'
            //     ? cubit
            //         .navigatorKeysAdmin[Constant.getIndex(cubit)].currentState!
            //         .maybePop()
            //     :  cubit.navigatorKeysStudent[Constant.getIndex(cubit)]
            //         .currentState!
            //         .maybePop();
          },
          child:  Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            body: Stack(
              children: List.generate(
                5,
                (index) {
                  return Offstage(
                    offstage: cubit.currentIndex != index,
                    child: Visibility(
                      maintainState: true,
                      visible: cubit.currentIndex == index,
                      child: Navigator(
                        key: cubit.navigatorKeys[index],
                        onGenerateInitialRoutes: (navigator, initialRoute) => [
                          MaterialPageRoute(
                            builder: (context) => cubit.getPage(index),
                          ),
                        ],
                        onGenerateRoute: (routeSettings) {
                          return AppRouter().generateRoute(routeSettings);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: BottomNavBar(cubit: cubit),
          ),
          // child: Scaffold(
          //   body: Stack(
          //     children: List.generate(Constant.getLength(cubit), (index) {
          //       return Offstage(
          //         offstage: Constant.getIndex(cubit) != index,
          //         child: Visibility(
          //           visible: Constant.getIndex(cubit) == index,
          //           child: Navigator(
          //             key: CachHelper.getData(key: 'role') == 'admin'
          //                 ? cubit.navigatorKeysAdmin[index]
          //                 : cubit.navigatorKeysStudent[index],
          //             onGenerateInitialRoutes: (navigator, initialRoute) => [
          //               MaterialPageRoute(
          //                 builder: (context) =>
          //                     CachHelper.getData(key: 'role') == 'admin'
          //                         ? cubit.getPageAdmin(index)
          //                         : cubit.getPageStudent(index),
          //               ),
          //             ],
          //             onGenerateRoute: (routeSettings) {
          //               return AppRouter().generateRoute(routeSettings);
          //             },
          //           ),
          //         ),
          //       );
          //     }),
          //   ),
          //   bottomNavigationBar: BottomNavBar(cubit: cubit),
          // ),
        );
      },
    );
  }
}
