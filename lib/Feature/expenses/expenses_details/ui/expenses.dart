import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/expenses/expenses_details/logic/cubit/expenses_cubit.dart';
import 'package:madarj/Feature/expenses/expenses_details/ui/widgets/expenses_body.dart';
import 'package:madarj/Feature/home/ui/widgets/home_top_icons.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExpensesCubit>()..getAllExpenses(context),
      child: Scaffold(
        backgroundColor: ColorsManager.mainGray,
        body: Stack(
          children: [
            const ExpensesBody(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
              child: const HomeTopIcons(),
            ),
          ],
        ),
      ),
    );
  }
}
