import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Feature/leave/leave_managment/data/model/new_holiday_response.dart';
import 'package:madarj/Feature/leave/leave_managment/logic/cubit/leave_manager_details_cubit.dart';
// import 'package:madarj/Feature/leave/leave_managment/data/model/holiday_request.dart';
// import 'package:madarj/Feature/leave/leave_managment/data/model/holiday_request.dart';
import 'package:madarj/generated/l10n.dart';

class LeaveManagerLogCard extends StatelessWidget {
  const LeaveManagerLogCard({super.key, required this.data, this.isPending});
  final HolidayRequestData data;

  final bool? isPending;
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
                SvgPicture.asset("assets/svgs/magic-star.svg"),
                const SizedBox(width: 4),
                Text(
                  data.createDate!.split(" ")[0],
                  style: TextStyles.font14BlackSemiBold,
                ),
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
                        S.of(context).Leave_Date,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(71, 84, 103, 1),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${data.requestDateFrom} - ${data.requestDateTo}",
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Total_Leave,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(71, 84, 103, 1),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        data.numberOfDays.toString(),
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isPending == true
                    ? AppTextButton(
                      buttonText: S.of(context).refuse,
                      buttonHeight: 30.h,
                      buttonWidth: 100.w,
                      textStyle: TextStyles.font14WhiteSemiBold,
                      onPressed: () {
                        print("data.id ${data.id}");
                        context.read<LeaveManagerDetailsCubit>().refuseTimeOff(
                          context,
                          data.id,
                        );
                      },
                      hintText: S.of(context).refuse,
                      backgroundColor: ColorsManager.red,
                    )
                    : const SizedBox.shrink(),
                isPending == true
                    ? data.state == "validate1"
                        ? AppTextButton(
                          buttonText: S.of(context).validate,
                          buttonHeight: 50.h,
                          buttonWidth: 100.w,
                          textStyle: TextStyles.font14WhiteSemiBold,
                          onPressed: () {
                            print("data.id ${data.id}");
                            context
                                .read<LeaveManagerDetailsCubit>()
                                .validateTimeOff(context, data.id);
                          },
                          hintText: S.of(context).validate,
                          backgroundColor: ColorsManager.mainColor1,
                        )
                        : AppTextButton(
                          buttonText: S.of(context).approve,
                          buttonHeight: 50.h,
                          buttonWidth: 100.w,
                          textStyle: TextStyles.font14WhiteSemiBold,
                          onPressed: () {
                            print("data.id ${data.id}");
                            context
                                .read<LeaveManagerDetailsCubit>()
                                .approveTimeOff(context, data.id);
                          },
                          hintText: S.of(context).approve,
                          backgroundColor: ColorsManager.mainColor1,
                        )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
