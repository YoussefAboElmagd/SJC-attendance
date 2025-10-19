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
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/attendance_manager/logic/attendance_manager_cubit.dart';
import 'package:madarj/Feature/attendance_manager/logic/attendance_manager_state.dart';
import 'package:madarj/Feature/attendance_manager/ui/widgets/attendance_top_manager_header.dart';
import 'package:madarj/Feature/attendance_manager/ui/widgets/main_tab_attendance_manager.dart';
import 'package:madarj/generated/l10n.dart';

class AttendanceManagerBody extends StatelessWidget {
  const AttendanceManagerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceManagerCubit, AttendanceManagerState>(
      builder: (context, state) {
        return const Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AttendanceManagerTopHeader(),
                AttendanceManagerContent(),
              ],
            ),
            // BottomLeaveManagerButton(),
          ],
        );
      },
    );
  }
}

class AttendanceManagerContent extends StatelessWidget {
  const AttendanceManagerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceManagerCubit, AttendanceManagerState>(
      buildWhen:
          (previous, current) =>
              current is GetEditRequestsLoading ||
              current is GetEditRequestsSuccess ||
              current is GetEditRequestsError,
      builder: (context, state) {
        return state.maybeWhen(
          getEditRequestsLoading: () {
            return const Center(child: CircularProgressIndicator());
          },
          getEditRequestsSuccess: (data1) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SizedBox(
                height: (MediaQuery.sizeOf(context).height - 200.h),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainTabAttendanceManager(),
                    SendAttendanceManagerListener(),
                  ],
                ),
              ),
            );
          },
          getEditRequestsError: (err) {
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

class SendAttendanceManagerListener extends StatelessWidget {
  const SendAttendanceManagerListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AttendanceManagerCubit, AttendanceManagerState>(
      listenWhen:
          (previous, current) =>
              current is ApproveRequestError ||
              current is ApproveRequestLoading ||
              current is ApproveRequestSuccess,
      listener: (BuildContext context, state) {
        state.whenOrNull(
          approveRequestError: (e) {
            context.popAlert();
            setUpErrorState(context, e);
          },
          approveRequestLoading: () {
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
          approveRequestSuccess: (data) {
            context.popAlert();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).edit_attendance_time_approved),
                backgroundColor: Colors.green,
              ),
            );
            context.read<AttendanceManagerCubit>().getAllEditRequests(context);
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
