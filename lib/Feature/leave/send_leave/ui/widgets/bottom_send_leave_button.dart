import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/leave/send_leave/data/model/holiday_request_model.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
import 'package:madarj/generated/l10n.dart';

class BottomSendLeaveButton extends StatelessWidget {
  const BottomSendLeaveButton({super.key});

  String? formatDate(DateTime? date) {
    if (date == null) return null;
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            final cubit = context.read<SendLeaveCubit>();

            if (cubit.startDate == null || cubit.endDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select leave duration'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            if (cubit.leaveCtegory?.text.isEmpty ?? true) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select leave category'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            cubit.submitLeaveRequest(
              HolidayRequestModel(
                requestDateFrom: formatDate(cubit.startDate),
                requestDateTo: formatDate(cubit.endDate),
                holidayStatusId: int.parse(
                  context.read<SendLeaveCubit>().leaveCtegoryId!.text.toString(),
                ),
                name: cubit.leaveCtegory!.text,
              ),
            );
          },
          child: Container(
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
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                S.of(context).Submit_Leave_button,
                style: TextStyles.font16WhiteSemiBold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}