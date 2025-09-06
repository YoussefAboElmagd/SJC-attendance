import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/send_expenses_body.dart';
import 'package:madarj/generated/l10n.dart';

class SendExpenBlocBuilder extends StatelessWidget {
  const SendExpenBlocBuilder({super.key, this.update, this.id});
  final bool? update;
  final int? id;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendExpensesCubit, SendExpensesState>(
      buildWhen:
          (prev, current) =>
              current is Loading ||
              current is Error ||
              current is CombinedSuccess ||
              current is CombinedSuccessForUpdate,
      builder: (context, state) {
        return state.maybeWhen(
          loading: () {
            return const LinearProgressIndicator(
              color: ColorsManager.mainColor2,
            );
          },
          combinedSuccess: (data1, data2) {
            return SendExpensesBody(
              requests: data1,
              categories: data2,
              update: false,
              id: null,
            );
          },
          combinedSuccessForUpdate: (data1, data2, data3) {
            return SendExpensesBody(
              requests: data1,
              categories: data2,
              expenseDetail: data3,
              update: true,
              id: id,
            );
          },
          error: (error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setUpErrorState(context, error);
            });
            return const SizedBox.shrink();
          },
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}

void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
  showDialog(
    barrierDismissible: false,

    context: context,
    builder:
        (context) => AlertDialog(
          icon: Icon(Icons.error, color: Colors.red, size: 32.w),
          content: Text(
            apiErrorModel.getAllErrorMessages(),
            style: TextStyles.font15DarkBlueMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
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
