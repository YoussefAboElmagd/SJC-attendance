import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/helpers/cache_helper.dart';
// import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/home/data/model/clock_status_response.dart';
import 'package:madarj/Feature/home/data/model/pay_period_response.dart';
import 'package:madarj/Feature/home/data/model/total_hours.dart';
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
import 'package:madarj/Feature/home/logic/cubit/home_state.dart';
import 'package:madarj/Feature/home/ui/widgets/biometric_bloc_listener.dart';
import 'package:madarj/Feature/home/ui/widgets/period_and_total_hours.dart';
import 'package:madarj/generated/l10n.dart';

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
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
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
                    color: const Color.fromRGBO(71, 84, 103, 1),
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
                      if (CacheHelper.getData(key: SharedKeys.skipBiometric) ==
                          true) {
                        // context.popAlert();
                        context.read<HomeCubit>().checkUser(context);
                      } else {
                        context
                            .read<HomeCubit>()
                            .checkBiometricsAndAuthenticate(
                              context: context,
                              isCheckIn: true,
                            );
                      }
                      // String? device =
                      //     await context.read<HomeCubit>().getDeviceIdentifier();

                      // print(device);
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
