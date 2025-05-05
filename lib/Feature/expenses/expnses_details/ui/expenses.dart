import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_body.dart';
import 'package:madarj/generated/l10n.dart';

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
        bottomNavigationBar: const BottomExpensesButton(),
      ),
    );
  }
}

class BottomExpensesButton extends StatelessWidget {
  const BottomExpensesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            context.pushNamed(Routes.sendExpenses);
          },
          child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(42, 49, 131, 1),
                  Color.fromRGBO(42, 49, 131, 1),
                  Color.fromRGBO(91, 46, 212, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                S.of(context).Submit_Expense,
                style: TextStyles.font16WhiteSemiBold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
