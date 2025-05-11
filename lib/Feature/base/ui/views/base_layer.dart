import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/routing/app_routes.dart';
import 'package:madarj/Feature/base/ui/views/widget/bottom_nav_bar.dart';

class BaseLayer extends StatefulWidget {
  final int initialIndex;

  const BaseLayer({super.key, this.initialIndex = 0});

  @override
  State<BaseLayer> createState() => _BaseLayerState();
}

class _BaseLayerState extends State<BaseLayer> {
  @override
  void initState() {
    super.initState();
    // Set the initial index when the widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = ApplicationCubit.get(context);
      if (cubit.currentIndex != widget.initialIndex) {
        cubit.emitChangeBottomNav(widget.initialIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        final cubit = ApplicationCubit.get(context);
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
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
// import 'package:madarj/Core/routing/app_routes.dart';
// import 'package:madarj/Feature/base/ui/views/widget/bottom_nav_bar.dart';
// // import 'package:madarj/Feature/base/presentation/manager/ui_cubit.dart';
// // import 'package:madarj/Feature/base/presentation/manager/ui_state.dart';
// // import 'package:madarj/Feature/base/presentation/views/widget/bottom_nav_bar.dart';

// class BaseLayer extends StatelessWidget {
//   const BaseLayer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ApplicationCubit, ApplicationState>(
//       builder: (context, state) {
//         var cubit = ApplicationCubit.get(context);
//         return WillPopScope(
//           onWillPop: () async {
//             return !await cubit.navigatorKeys[cubit.currentIndex].currentState!
//                 .maybePop();
//           },
//           child: Scaffold(
//             backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//             body: Stack(
//               children: List.generate(
//                 5,
//                 (index) {
//                   return Offstage(
//                     offstage: cubit.currentIndex != index,
//                     child: Visibility(
//                       visible: cubit.currentIndex == index,
//                       child: Navigator(
//                         key: cubit.navigatorKeys[index],
//                         onGenerateInitialRoutes: (navigator, initialRoute) => [
//                           MaterialPageRoute(
//                             builder: (context) => cubit.getPage(index),
//                           ),
//                         ],
//                         onGenerateRoute: (routeSettings) {
//                           return AppRouter().generateRoute(routeSettings);
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             bottomNavigationBar: BottomNavBar(cubit: cubit),
//           ),
//         );
//       },
//     );
//   }
// }
