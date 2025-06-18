import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/expenses/expnses_details/logic/cubit/expenses_cubit.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_body.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pushNamed(Routes.cardsScreen);

        // SystemNavigator.pop();
        return true;
      },
      child: BlocProvider(
        create: (context) => getIt<ExpensesCubit>()..getAllExpenses(context),
        child: Scaffold(
          backgroundColor: ColorsManager.mainGray,
          body: const ExpensesBody(),
        ),
      ),
    );
  }
}
