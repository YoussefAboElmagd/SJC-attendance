import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/expnses_details/logic/cubit/expenses_cubit.dart';
import 'package:madarj/Feature/expenses/expnses_details/logic/cubit/expenses_state.dart';
import 'package:madarj/Feature/expenses/expnses_details/ui/widgets/expenses_success.dart';
import 'package:madarj/generated/l10n.dart';

class ExpensesBody extends StatelessWidget {
  const ExpensesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      buildWhen: (previous, current) =>
          current is GetAllExpensesLoading ||
          current is GetAllExpensesError ||
          current is GetAllExpensesCombinedSuccess,
      builder: (context, state) {
        return state.maybeWhen(
          getAllExpensesLoading: () {
            return const LinearProgressIndicator(
              color: ColorsManager.mainColor2,
            );
          },
          getAllExpensesCombinedSuccess: (data1, data2, data3) {
            return ExpensesSuccess(
              newExpensesData: data1,
              pendingExpensesData: data2,
              doneExpensesData: data3,
            );
          },
          getAllExpensesError: (er) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // context.pop();
              setUpErrorState(context, er);
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

  void setUpErrorState(
    BuildContext context,
    ApiErrorModel apiErrorModel,
  ) async {
    final isMultipleErrors =
        apiErrorModel.errors != null && apiErrorModel.errors!.isNotEmpty;

    final errorMessage = isMultipleErrors
        ? apiErrorModel.errors!.values.join('\n')
        : apiErrorModel.message ?? 'An unexpected error occurred';
    if (apiErrorModel.message == "token seems to have expired or invalid") {
      CachHelper.removeData(key: SharedKeys.userToken);
      CachHelper.clearAllSecuredData();
      context.pushNamedAndRemoveUntill(Routes.loginScreen);
      AppConstants.isLogged = false;
      await CachHelper.saveData(key: SharedKeys.isLogged, value: false);
      DioFactory.setTokenAfterLogin(null);
      Fluttertoast.showToast(
        msg: apiErrorModel.message!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      context.pushNamedAndRemoveUntill(Routes.loginScreen);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: Icon(Icons.error, color: Colors.red, size: 32.w),
            content: Text(errorMessage, style: TextStyles.font15DarkBlueMedium),
            actions: [
              TextButton(
                onPressed:
                    apiErrorModel.message !=
                        "token seems to have expired or invalid"
                    ? () {
                        context.pushNamed(Routes.cardsScreen);
                      }
                    : () async {
                        CachHelper.removeData(key: SharedKeys.userToken);
                        CachHelper.clearAllSecuredData();
                        context.pushNamedAndRemoveUntill(Routes.loginScreen);
                        AppConstants.isLogged = false;
                        await CachHelper.saveData(
                          key: SharedKeys.isLogged,
                          value: false,
                        );
                        DioFactory.setTokenAfterLogin(null);
                      },
                // onPressed: () {
                //   apiErrorModel.message != "token seems to have expired or invalid"
                //       ? context.pop()
                //       : context.pushNamedAndRemoveUntill(Routes.loginScreen);
                // },
                child: Text(
                  apiErrorModel.message !=
                          "token seems to have expired or invalid"
                      ? 'Got it'
                      : S.of(context).Login_button,
                  style: TextStyles.font14BlueSemiBold,
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
