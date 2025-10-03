import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Feature/attendance_manager/data/model/edit_request_item.dart';
import 'package:madarj/Feature/attendance_manager/logic/attendance_manager_cubit.dart';
import 'package:madarj/Feature/attendance_manager/ui/widgets/approve_bottom_sheet.dart';
import 'package:madarj/generated/l10n.dart';

class AttendanceLogManagerCard extends StatelessWidget {
  const AttendanceLogManagerCard({
    super.key,
    required this.data,
    this.isPending,
    this.isApprove,
  });

  final RequestItem data;
  final bool? isApprove;
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
                  data.createdOn!.split(" ")[0],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachHelper.getData(key: SharedKeys.isTimeOff) == 'manager'
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).employee_name,
                            style: TextStyles.font14BlackSemiBold.copyWith(
                              fontSize: 12.sp,
                              color: const Color.fromRGBO(71, 84, 103, 1),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            data.employeeName ?? S.of(context).no_name,
                            style: TextStyles.font14BlackSemiBold,
                          ),
                        ],
                      )
                      : const SizedBox.shrink(),
                  SizedBox(height: 8.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).checkin_old,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(71, 84, 103, 1),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${data.checkInOld!.toArabicDate().split(" ")[0]}  <= ${data.checkInOld!.toArabicDate().split(" ")[1].split(":")[0]}:${data.checkInOld!.toArabicDate().split(" ")[1].split(":")[1]}",
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).Checkoutn_old,
                        style: TextStyles.font14BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(71, 84, 103, 1),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${data.checkOutOld!.toArabicDate().split(" ")[0]}  <= ${data.checkOutOld!.toArabicDate().split(" ")[1].split(":")[0]}:${data.checkOutOld!.toArabicDate().split(" ")[1].split(":")[1]}",
                        style: TextStyles.font14BlackSemiBold,
                      ),
                    ],
                  ),
                  isApprove == true
                      ? SizedBox(height: 8.h)
                      : SizedBox(height: 0.h),
                  isApprove == true
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).checkin_new,
                            style: TextStyles.font14BlackSemiBold.copyWith(
                              fontSize: 12.sp,
                              color: const Color.fromRGBO(71, 84, 103, 1),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${data.checkInNeW!.toArabicDate().split(" ")[0]}  <= ${data.checkInOld!.toArabicDate().split(" ")[1].split(":")[0]}:${data.checkInOld!.toArabicDate().split(" ")[1].split(":")[1]}",
                            style: TextStyles.font14BlackSemiBold,
                          ),
                        ],
                      )
                      : const SizedBox.shrink(),

                  isApprove == true
                      ? SizedBox(height: 8.h)
                      : SizedBox(height: 0.h),
                  isApprove == true
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).Checkoutn_new,
                            style: TextStyles.font14BlackSemiBold.copyWith(
                              fontSize: 12.sp,
                              color: const Color.fromRGBO(71, 84, 103, 1),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${data.checkOutNeW!.toArabicDate().split(" ")[0]}  <= ${data.checkOutOld!.toArabicDate().split(" ")[1].split(":")[0]}:${data.checkOutOld!.toArabicDate().split(" ")[1].split(":")[1]}",
                            style: TextStyles.font14BlackSemiBold,
                          ),
                        ],
                      )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isPending == true &&
                        CachHelper.getData(key: SharedKeys.isTimeOff) ==
                            'manager'
                    ? AppTextButton(
                      buttonWidth: MediaQuery.sizeOf(context).width * .25,
                      buttonText: S.of(context).approve,
                      backgroundColor: ColorsManager.mainColor1,
                      textStyle: TextStyles.font14WhiteSemiBold,
                      onPressed: () async {
                        final result = await showApproveRequestBottomSheet(
                          context,
                          initialCheckIn: data.checkInOld,
                          initialCheckOut: data.checkOutOld,
                          employeeName: data.employeeName,
                        );

                        if (result != null) {
                          var checkIn =
                              result.checkInNew!.split("=>").length == 2
                                  ? "${result.checkInNew!.split("=>")[0]}${result.checkInNew!.split("=>")[1]}"
                                      .replaceFirst("  ", " ")
                                  : result.checkInNew!;
                          var checkOut =
                              result.checkOutNew!.split("=>").length == 2
                                  ? "${result.checkOutNew!.split("=>")[0]}${result.checkOutNew!.split("=>")[1]}"
                                      .replaceFirst("  ", " ")
                                  : result.checkOutNew;
                          print(checkIn);
                          print(checkOut);
                          context.read<AttendanceManagerCubit>().approveRequest(
                            context,
                            requestId: data.id!,
                            checkInNew: checkIn,
                            checkOutNew: checkOut!,
                          );
                        }
                      },
                      hintText: "",
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
