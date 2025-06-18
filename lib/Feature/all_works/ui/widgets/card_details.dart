import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/all_works/data/model/get_month_work_response.dart';
import 'package:madarj/generated/l10n.dart';

class CardDetails extends StatelessWidget {
  final WorkDayEntry workDayEntry;

  const CardDetails({super.key, required this.workDayEntry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _infoColumn(
            S.of(context).Total_Hours,
            ApplicationCubit.get(context).isArabic
                ? workDayEntry.workedHours!
                    .replaceAll("and", "&")
                    .replaceAll("Hrs", "س")
                    .replaceAll("Mins", "دق")
                : workDayEntry.workedHours!.replaceAll("and", "&"),
          ),
          _infoColumn(
            S.of(context).Clock_in_Out,
            "${workDayEntry.checkIn == null ? S.of(context).No_checkIn : ApplicationCubit.get(context).isArabic ? workDayEntry.checkIn!.replaceAll("PM", "ص").replaceAll("AM", "م") : workDayEntry.checkIn!} - ${workDayEntry.checkOut == null ? S.of(context).No_checkout : ApplicationCubit.get(context).isArabic ? workDayEntry.checkOut!.replaceAll("PM", "ص").replaceAll("AM", "م") : workDayEntry.checkOut!}",
          ),
        ],
      ),
    );
  }

// Text(
//                         style: TextStyles.font14BlackSemiBold,
//                       ),
  Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.font14BlackSemiBold.copyWith(
            fontSize: 12.sp,
            color: const Color.fromRGBO(71, 84, 103, 1),
          ),
        ),
        SizedBox(height: 4.h),
        Text(value, style: TextStyles.font14BlackSemiBold),
      ],
    );
  }
}
