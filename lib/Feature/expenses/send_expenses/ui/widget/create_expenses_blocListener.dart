import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/generated/l10n.dart';

class CreateExpensesBlocListener extends StatelessWidget {
  const CreateExpensesBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendExpensesCubit, SendExpensesState>(
      listenWhen: (prevoius, current) =>
          current is CreateExpensesLoading ||
          current is CreateExpensesSuccess ||
          current is CreateExpensesError,
      listener: (BuildContext context, state) {
        state.whenOrNull(
          createExpensesLoading: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainColor,
                ),
              ),
            );
          },
          createExpensesSuccess: (response) async {
            context.pop();
            Fluttertoast.showToast(
              msg: S.of(context).Successfully_sent_expenses,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            context.pushNamedAndRemoveUntill(Routes.expenseScreen);
          },
          createExpensesError: (error) {
            context.pop();
            setUpErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error, color: Colors.red, size: 32),
        content: Text(
          apiErrorModel.message!,
          style: TextStyles.font15DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.popAlert();
            },
            child: Text(
              S.of(context).close_it,
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
