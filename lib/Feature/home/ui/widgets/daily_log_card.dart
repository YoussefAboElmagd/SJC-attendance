// -----------------------------------------------------------------------------
// File: daily_log_card.dart
// Description: Short description of this file.
// Author(s): Original Author Name
// Edited by: Ahmed Eid Ibrahim
// Last Modified: 2025-10-21
// changelog:
// 2025-10-21: Ahmed Eid Ibrahim – add other behavior when admin tap on edit attendance button.
// 2025-10-22: Ahmed Eid Ibrahim – delete bool for check in and out
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/enums/attendance_enum.dart';
import 'package:madarj/Core/functions/format_time_to_full_date_time.dart';
import 'package:madarj/Core/helpers/cache_helper.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Feature/attendance_manager/ui/widgets/approve_bottom_sheet.dart';
import 'package:madarj/Feature/home/data/model/attendance_edit_manager_request.dart';
import 'package:madarj/Feature/home/data/model/get_today_work_response.dart';
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
                      onPressed: () async {
                        // print(workDayEntry.id);
                        // TODO: change after osama info

                        final isAttendance = CacheHelper.getData(
                          key: SharedKeys.isAttendance,
                        );
                        if (isAttendance == AttendanceEnum.manager.name) {
                          final result = await showApproveRequestBottomSheet(
                            context,
                            initialCheckIn: formatTimeToFullDateTime(
                              workDayEntry.checkIn!,
                            ),
                            initialCheckOut: formatTimeToFullDateTime(
                              workDayEntry.checkOut!,
                            ),
                          );

                          if (result != null) {
                            var checkIn =
                                result.checkInNew!.split("=>").length == 2
                                    ? "${result.checkInNew!.split("=>")[0]}${result.checkInNew!.split("=>")[1]}"
                                        .replaceFirst("  ", " ")
                                    : result.checkInNew!;
                            print(" checkIn: $checkIn");
                            var checkOut =
                                result.checkOutNew!.split("=>").length == 2
                                    ? "${result.checkOutNew!.split("=>")[0]}${result.checkOutNew!.split("=>")[1]}"
                                        .replaceFirst("  ", " ")
                                    : result.checkOutNew;
                            print(" checkOut: $checkOut");

                            await context
                                .read<HomeCubit>()
                                .attendanceEditManager(
                                  context,
                                  AttendanceEditManagerRequest(
                                    attendanceId: workDayEntry.id!.toInt(),
                                    checkIn: checkIn,
                                    checkOut: checkOut,
                                  ),
                                );
                          }
                        } else if (isAttendance == AttendanceEnum.user.name) {
                          await context.read<HomeCubit>().createEditRequest(
                            context,
                            workDayEntry.id!.toInt(),
                          );
                        }
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
