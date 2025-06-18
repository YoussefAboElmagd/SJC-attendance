import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
import 'package:madarj/Feature/home/ui/widgets/clock_in_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getAllHome2(context),
      child: const HomeScreenBody(),
    );
  }
}
