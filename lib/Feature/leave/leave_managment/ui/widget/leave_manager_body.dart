import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Core/themes/colors.dart';
// import 'package:madarj/Feature/leave/leave_details/logic/cubit/leave_details_cubit.dart';
// import 'package:madarj/Feature/leave/leave_details/logic/cubit/leave_details_state.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/styles.dart';
// import 'package:madarj/Feature/leave/leave_details/logic/cubit/leave_details_cubit.dart';
// import 'package:madarj/Feature/leave/leave_managment/data/model/new_holiday_response.dart';
// import 'package:madarj/Feature/leave/leave_details/logic/cubit/leave_details_state.dart';
import 'package:madarj/Feature/leave/leave_managment/logic/cubit/leave_manager_details_cubit.dart';
import 'package:madarj/Feature/leave/leave_managment/logic/cubit/leave_manager_details_state.dart';
import 'package:madarj/Feature/leave/leave_managment/ui/leave_manager_screen.dart';
import 'package:madarj/Feature/leave/leave_managment/ui/widget/leave_body_manager_widgets.dart';
import 'package:madarj/Feature/leave/leave_managment/ui/widget/leave_top_manager_header.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveManagerBody extends StatelessWidget {
  const LeaveManagerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveManagerDetailsCubit, LeaveManagerDetailsState>(
      builder: (context, state) {
        return const Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [LeaveManagerTopHeader(), LeavesManagerContent()],
            ),
            // BottomLeaveManagerButton(),
          ],
        );
      },
    );
  }
}

class LeavesManagerContent extends StatelessWidget {
  const LeavesManagerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveManagerDetailsCubit, LeaveManagerDetailsState>(
      buildWhen:
          (previous, current) =>
              current is GetAllLeaveLoading ||
              current is GetAllLeaveError ||
              current is GetAllLeaveCombinedSuccess,
      builder: (context, state) {
        return state.maybeWhen(
          getAllLeaveLoading: () {
            return const Center(child: CircularProgressIndicator());
          },
          getAllLeaveCombinedSuccess: (data1, data2, data3, data4) {
            // print(data1);
            // print(data2);
            print(data3.data);
            print("data4.data ${data4.data}");
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SizedBox(
                height: (MediaQuery.sizeOf(context).height - 200.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeaveBodyManagerWidgets(timeoffBalanceData: data1),
                    const SendLeaveManagerListener(),
                  ],
                ),
              ),
            );
          },
          getAllLeaveError: (err) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setUpErrorState(context, err);
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

class SendLeaveManagerListener extends StatelessWidget {
  const SendLeaveManagerListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LeaveManagerDetailsCubit, LeaveManagerDetailsState>(
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
            context.read<LeaveManagerDetailsCubit>().getAllLeaves(context);
          },
          approveTimeOffError: (e) {
            context.popAlert();
            setUpErrorState(context, e);
          },
          approveTimeOffLoading: () {
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
          approveTimeOffSuccess: (data) {
            context.popAlert();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).Approve_Leave),
                backgroundColor: Colors.green,
              ),
            );
            context.read<LeaveManagerDetailsCubit>().getAllLeaves(context);
          },
          refuseTimeOffError: (e) {
            context.popAlert();
            setUpErrorState(context, e);
          },
          refuseTimeOffLoading: () {
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
          refuseTimeOffSuccess: (data) {
            context.popAlert();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).Refuse_Leave),
                backgroundColor: Colors.green,
              ),
            );
            context.read<LeaveManagerDetailsCubit>().getAllLeaves(context);
          },
          validateTimeOffError: (e) {
            context.popAlert();
            setUpErrorState(context, e);
          },
          validateTimeOffLoading: () {
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
          validateTimeOffSuccess: (data) {
            context.popAlert();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).validation_Leave),
                backgroundColor: Colors.green,
              ),
            );
            context.read<LeaveManagerDetailsCubit>().getAllLeaves(context);
          },
        );
      },

      child: const SizedBox.shrink(),
    );
  }
}

void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) async {
  if (!context.mounted) return;

  final isMultipleErrors =
      apiErrorModel.errors != null && apiErrorModel.errors!.isNotEmpty;

  final errorMessage =
      isMultipleErrors
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
                  apiErrorModel.message != S.of(context).token_expired
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
