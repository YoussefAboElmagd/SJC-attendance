import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madarj/Core/helpers/cache_helper.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/leave/leave_details/logic/cubit/leave_details_cubit.dart';
import 'package:madarj/Feature/leave/leave_details/logic/cubit/leave_details_state.dart';
import 'package:madarj/Feature/leave/leave_details/ui/leave_screen.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/leave_body_widgets.dart';
import 'package:madarj/Feature/leave/leave_details/ui/widget/leave_top_header.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveBody extends StatelessWidget {
  const LeaveBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveDetailsCubit, LeaveDetailsState>(
      builder: (context, state) {
        return const Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [LeaveTopHeader(), LeavesContent()],
            ),
            BottomLeaveButton(),
          ],
        );
      },
    );
  }
}

class LeavesContent extends StatelessWidget {
  const LeavesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveDetailsCubit, LeaveDetailsState>(
      buildWhen:
          (previous, current) =>
              current is GetAllLeaveLoading ||
              current is GetAllLeaveError ||
              current is GetAllLeaveCombinedSuccess,
      builder: (context, state) {
        // Handle error state after build is complete
        if (state is GetAllLeaveError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setUpErrorState(context, state.error);
          });
          return const SizedBox.shrink();
        }

        return state.maybeWhen(
          getAllLeaveLoading: () {
            return const Center(child: CircularProgressIndicator());
          },
          getAllLeaveCombinedSuccess: (data1, data2, data3, data4) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SizedBox(
                height: (MediaQuery.sizeOf(context).height - 200.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeaveBodyWidgets(
                      timeoffBalanceData: data1,
                      requestsApprovedData: data2,
                      requestsPendingData: data3,
                      requestsRefusedData: data4,
                    ),
                    const SendLeaveListener(),
                  ],
                ),
              ),
            );
          },
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}

class SendLeaveListener extends StatelessWidget {
  const SendLeaveListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LeaveDetailsCubit, LeaveDetailsState>(
      listener: (BuildContext context, state) {
        state.whenOrNull(
          cancelTimeOffError: (e) {
            context.popAlert();
            setUpErrorState(context, e);
          },
          cancelTimeOffLoading: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder:
                  (context) => const Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.mainColor,
                    ),
                  ),
            );
          },
          cancelTimeOffSuccess: () {
            context.popAlert();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('canel Leave'),
                backgroundColor: Colors.green,
              ),
            );
            context.read<LeaveDetailsCubit>().getAllLeaves(context);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}

void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) async {
  // Only show dialog if the widget is still mounted
  if (!context.mounted) return;

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
  // showDialog(
  //   context: context,
  //   builder: (context) => AlertDialog(
  //     icon: Icon(Icons.error, color: Colors.red, size: 32.w),
  //     content: Text(errorMessage, style: TextStyles.font15DarkBlueMedium),
  //     actions: [
  //       TextButton(
  //         onPressed:
  //             apiErrorModel.message != S.of(context).token_expired
  //             ? () {
  //                 context.pushNamed(Routes.cardsScreen);
  //               }
  //             : () async {
  //                 CachHelper.removeData(key: SharedKeys.userToken);
  //                 CachHelper.clearAllSecuredData();
  //                 context.pushNamedAndRemoveUntill(Routes.loginScreen);
  //                 AppConstants.isLogged = false;
  //                 await CachHelper.saveData(
  //                   key: SharedKeys.isLogged,
  //                   value: false,
  //                 );
  //                 DioFactory.setTokenAfterLogin(null);
  //               },
  //         child: Text(
  //           apiErrorModel.message != S.of(context).token_expired
  //               ? S.of(context).close_it
  //               : S.of(context).Login_button,
  //           style: TextStyles.font14BlueSemiBold,
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}
