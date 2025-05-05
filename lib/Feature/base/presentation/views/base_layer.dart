import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/routing/app_routes.dart';
// import 'package:madarj/Feature/base/presentation/manager/ui_cubit.dart';
// import 'package:madarj/Feature/base/presentation/manager/ui_state.dart';
import 'package:madarj/Feature/base/presentation/views/widget/bottom_nav_bar.dart';

class BaseLayer extends StatelessWidget {
  const BaseLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        var cubit = ApplicationCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            return !await cubit.navigatorKeys[cubit.currentIndex].currentState!
                .maybePop();
          },
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            body: Stack(
              children: List.generate(
                5,
                (index) {
                  return Offstage(
                    offstage: cubit.currentIndex != index,
                    child: Visibility(
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
        );
      },
    );
  }
}
