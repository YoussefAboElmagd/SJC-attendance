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
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
import 'package:madarj/Feature/home/logic/cubit/home_state.dart';
import 'package:madarj/Feature/home/ui/widgets/clock_in.dart';
import 'package:madarj/Feature/home/ui/widgets/clock_in_shimmer.dart';
import 'package:madarj/Feature/home/ui/widgets/list_of_checks.dart';
import 'package:madarj/Feature/home/ui/widgets/list_of_checks_shimmer.dart';
import 'package:madarj/generated/l10n.dart';

class PeriodAndTotalHoursBuilder extends StatelessWidget {
  const PeriodAndTotalHoursBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              current is Loading ||
              current is CombinedSuccess ||
              current is Error,
      builder: (BuildContext context, state) {
        return state.maybeWhen(
          loading: () {
            return const Expanded(
              child: Column(
                children: [ClockInShimmer(), ListOfchecksShimmer()],
              ),
            );
          },
          combinedSuccess: (data, data2, data3, data4) {
            if (data4.attendanceState == "checked_in") {
              context.read<HomeCubit>().clockInText = S.of(context).Clock_Out;
            }
            if (data4.attendanceState == "checked_out") {
              context.read<HomeCubit>().clockInText = S.of(context).Clock_In;
            }
            return Expanded(
              child: Column(
                children: [
                  ClockIn(
                    payPeriodResponse: data,
                    totalHours: data2,
                    clockStatusResponse: data4,
                  ),
                  ListOfchecks(workDayEntries: data3),
                ],
              ),
            );
          },
          error: (errorHandler) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setUpErrorState(context, errorHandler);
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
              // onPressed: () {
              //   apiErrorModel.message != S.of(context).token_expired
              //       ? context.pop()
              //       : context.pushNamedAndRemoveUntill(Routes.loginScreen);
              // },
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
