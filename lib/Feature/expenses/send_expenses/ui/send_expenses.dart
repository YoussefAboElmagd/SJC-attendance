import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/bottom_expenses_button.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/send_expen_bloc_builder.dart';
import 'package:madarj/generated/l10n.dart';

class SendExpenses extends StatelessWidget {
  const SendExpenses({super.key, this.update, this.id});
  final bool? update;
  final int? id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SendExpensesCubit>()
        ..getAllExpenses(
          context,
          id == 0 ? null : id,
        ),
      child: Scaffold(
        backgroundColor: ColorsManager.mainGray,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20.w,
            ),
          ),
          centerTitle: true,
          title: Text(
            S.of(context).Submit_Expense,
            style: TextStyles.font20BlackSemiBold,
          ),
        ),
        body: SendExpenBlocBuilder(
          update: update,
          id: id,
        ),
        bottomNavigationBar: BottomSendExpensesButton(
          update: update,
          id: id,
        ),
      ),
    );
  }
}
