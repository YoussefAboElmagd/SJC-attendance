import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madarj/Core/helpers/cache_helper.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/all_works/ui/widgets/list_of_checks_shimmer.dart';
import 'package:madarj/Feature/payroll/logic/cubit/payroll_cubit.dart';
import 'package:madarj/Feature/payroll/logic/cubit/payroll_state.dart';
import 'package:madarj/Feature/payroll/ui/widget/list_of_checks.dart';
import 'package:madarj/generated/l10n.dart';

class PayrollBuilder extends StatelessWidget {
  const PayrollBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayrollCubit, PayrollState>(
      buildWhen:
          (previous, current) =>
              current is GetEmployeePayslipsLoading ||
              current is GetEmployeePayslipsSuccess ||
              current is GetEmployeePayslipsError,
      builder: (context, state) {
        return state.maybeWhen(
          getEmployeePayslipsLoading: () => const ListOfChecksShimmer(),
          getEmployeePayslipsSuccess: (data) => ListOfChecks(data: data.data),
          getEmployeePayslipsError: (error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setUpErrorState(context, error);
            });
            return const SizedBox.shrink();
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) async {
  final isMultipleErrors =
      apiErrorModel.errors != null && apiErrorModel.errors!.isNotEmpty;

  final errorMessage =
      isMultipleErrors
          ? apiErrorModel.errors!.values.join('\n')
          : apiErrorModel.message ?? 'An unexpected error occurred';
  if (apiErrorModel.message == "token seems to have expired or invalid") {
    CacheHelper.removeData(key: SharedKeys.userToken);
    CacheHelper.clearAllSecuredData();
    context.pushNamedAndRemoveUntill(Routes.loginScreen);
    AppConstants.isLogged = false;
    await CacheHelper.saveData(key: SharedKeys.isLogged, value: false);
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
                  apiErrorModel.message != S.of(context).token_expired
                      ? () {
                        context.pushNamed(Routes.cardsScreen);
                      }
                      : () async {
                        CacheHelper.removeData(key: SharedKeys.userToken);
                        CacheHelper.clearAllSecuredData();
                        context.pushNamedAndRemoveUntill(Routes.loginScreen);
                        AppConstants.isLogged = false;
                        await CacheHelper.saveData(
                          key: SharedKeys.isLogged,
                          value: false,
                        );
                        DioFactory.setTokenAfterLogin(null);
                      },
              child: Text(
                apiErrorModel.message != S.of(context).token_expired
                    ? S.of(context).close_it
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
