import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/extensions.dart';
// import 'package:madarj/Core/helpers/shared_key.dart';
// import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/home/data/model/clock_status_response.dart';
import 'package:madarj/Feature/home/data/model/pay_period_response.dart';
import 'package:madarj/Feature/home/data/model/total_hours.dart';
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
import 'package:madarj/Feature/home/logic/cubit/home_state.dart';
import 'package:madarj/Feature/home/ui/widgets/period_and_total_hours.dart';
// import 'package:madarj/Feature/home/ui/widgets/period_and_total_hours_builder.dart';
import 'package:intl/intl.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class ClockIn extends StatelessWidget {
  const ClockIn({
    super.key,
    required this.payPeriodResponse,
    required this.totalHours,
    required this.clockStatusResponse,
  });
  final PayPeriodResponse payPeriodResponse;
  final TotalHours totalHours;
  final ClockStatusResponse clockStatusResponse;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                15.r,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).Total_Working_Hour,
                  style: TextStyles.font16BlackSemiBold,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${S.of(context).Paid_Period} 1 ${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().year} - 30 ${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().year}',
                  style: TextStyles.font14BlackSemiBold.copyWith(
                    color: const Color.fromRGBO(
                      71,
                      84,
                      103,
                      1,
                    ),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 12.h),
                PeriodAndTotalHours(
                  payPeriodResponse: payPeriodResponse,
                  totalHours: totalHours,
                ),
                SizedBox(height: 20.h),
                Container(
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
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      context.read<HomeCubit>().checkBiometricsAndAuthenticate(
                            context: context,
                            isCheckIn: true,
                          );
                      String? device =
                          await context.read<HomeCubit>().getDeviceIdentifier();

                      print(device);
                    },
                    child: Text(
                      context.read<HomeCubit>().clockInText != null
                          ? context.read<HomeCubit>().clockInText!
                          : clockStatusResponse.attendanceState == "clock_in"
                              ? S.of(context).Clock_In
                              : S.of(context).Clock_Out,
                      style: TextStyles.font16WhiteSemiBold,
                    ),
                  ),
                ),
                const BiometricBlocListener(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ClockInShimmer extends StatelessWidget {
  const ClockInShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150.w,
                height: 20.h,
                color: Colors.white,
              ),
              SizedBox(height: 4.h),
              Container(
                width: 250.w,
                height: 14.h,
                color: Colors.white,
              ),
              SizedBox(height: 12.h),
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BiometricBlocListener extends StatelessWidget {
  const BiometricBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          current is HomeAuthenticating ||
          current is HomeAuthenticationFailed ||
          current is AuthError ||
          current is HomeAuthenticated ||
          current is HomeAuthenticationLockedOut,
      listener: (context, state) {
        state.whenOrNull(authenticating: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainColor2,
              ),
            ),
          );
        }, authenticationFailed: () {
          context.popAlert();
          _showErrorDialog(context, S.of(context).Authentication_Failed,
              S.of(context).Biometric_authentication_failed_Please_try_again
              // 'Biometric authentication failed. Please try again.',
              );
        }, authError: (apiError) {
          // context.pop();
          context.popAlert();
          _showErrorDialog(
            context,
            S.of(context).Authentication_Failed,
            '${apiError.message}',
          );
        }, lockedOut: () {
          // context.pop();
          context.popAlert();
          _showErrorDialog(
            context,
            S.of(context).Locked_Out,
            S.of(context).Too_many_failed_attempts_Try_again_later,
            // 'Too many failed attempts. Try again later.',
          );
        }, authenticated: (v) {
          // context.pop();
          context.popAlert();
          context.read<HomeCubit>().checkUser(context);

          // context.pushNamed(Routes.clockInScreen);
        });
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.error, color: Colors.red, size: 32.w),
        title: Text(title),
        content: Text(
          message,
          style: TextStyles.font15DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Got it',
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
