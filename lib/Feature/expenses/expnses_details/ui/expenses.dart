import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_body.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorsManager.mainGray,
        body: const ExpensesBody(),
        // bottomNavigationBar:
      ),
    );
  }
}
