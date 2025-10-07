import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Feature/home/data/model/get_today_work_response.dart';
import 'package:intl/intl.dart';
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
// import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
import 'package:madarj/generated/l10n.dart';

class DailyLogCard extends StatelessWidget {
  final TodayWorkDayEntry workDayEntry;

  const DailyLogCard({super.key, required this.workDayEntry});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svgs/calendar.svg"),
                const SizedBox(width: 4),
                Text(
                  "${DateTime.now().day} ${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().year}",
                  style: TextStyles.font14BlackSemiBold,
                ),
                const Spacer(),
                workDayEntry.hasRequest == false &&
                        workDayEntry.checkOut != null
                    ? AppTextButton(
                      buttonWidth: MediaQuery.sizeOf(context).width * .4,
                      onPressed: () {
                        // print(workDayEntry.id);
                        context.read<HomeCubit>().createEditRequest(
                          context,
                          workDayEntry.id!.toInt(),
                        );
                      },
                      buttonText: S.of(context).request_attendance,
                      textStyle: TextStyles.font16WhiteBold,
                      hintText: '',
                      backgroundColor: ColorsManager.mainColor1,
                    )
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Total_Hours,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(71, 84, 103, 1),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        ApplicationCubit.get(context).isArabic
                            ? workDayEntry.workedHours!
                                .replaceAll("and", "&")
                                .replaceAll("Hrs", "س")
                                .replaceAll("Mins", "دق")
                            : workDayEntry.workedHours!.replaceAll("and", "&"),
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Clock_in_Out,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(71, 84, 103, 1),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${workDayEntry.checkIn == null
                            ? S.of(context).No_checkIn
                            : ApplicationCubit.get(context).isArabic
                            ? workDayEntry.checkIn!.replaceAll("PM", "م").replaceAll("AM", "ص")
                            : workDayEntry.checkIn!} - ${workDayEntry.checkOut == null
                            ? S.of(context).No_checkout
                            : ApplicationCubit.get(context).isArabic
                            ? workDayEntry.checkOut!.replaceAll("PM", "م").replaceAll("AM", "ص")
                            : workDayEntry.checkOut!}",
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
