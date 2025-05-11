import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_text_field.dart';
// import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_drop_down.dart';
// import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_text_field.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_state.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/Leave_build_drop_down.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/leave_duration_buttons.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:madarj/Core/helpers/extensions.dart';

class SendLeaveForms extends StatelessWidget {
  const SendLeaveForms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendLeaveCubit, SendLeaveState>(
      builder: (context, state) {
        return Column(
          children: [
            BuildDropdown(
              label: S.of(context).Leave_Category,
              // hint: S.of(context).Select_Category,
              icon: "assets/svgs/summary-expenses(1).svg",
              hint: context.read<SendLeaveCubit>().leaveCtegory?.text.isEmpty ??
                      true
                  ? S.of(context).Select_Category
                  : context.read<SendLeaveCubit>().leaveCtegory!.text,
              items: const [
                "ssss2",
                "ssss1",
                "ssss3",
                "ssss4",
                "ssss5",
                "ssss6",
                "ssss7",
                "ssss8",
              ],
              controller: context.read<SendLeaveCubit>().leaveCtegory,
            ),
            SizedBox(height: 16.h),
            BuildDropdown(
              label: S.of(context).Leave_Duration,
              hint:
                  context.read<SendLeaveCubit>().leaveDuration?.text.isEmpty ??
                          true
                      ? S.of(context).Select_Duration
                      : context
                          .read<SendLeaveCubit>()
                          .leaveDuration!
                          .text
                          .toFormattedDateRange(),
              onTap: () => showDateRangeBottomSheet(
                context,
                context.read<SendLeaveCubit>(),
                context.read<SendLeaveCubit>().leaveDuration!,
              ),
              icon: "assets/svgs/summary-expenses(2).svg",
              items: const [
                "ssss2",
                "ssss1",
                "ssss3",
                "ssss4",
                "ssss5",
                "ssss6",
                "ssss7",
                "ssss8",
              ],
              controller: context.read<SendLeaveCubit>().leaveDuration,
            ),
            SizedBox(height: 16.h),
            BuildDropdown(
              label: S.of(context).Task_Delegation,
              hint:
                  context.read<SendLeaveCubit>().taskDelegation?.text.isEmpty ??
                          true
                      ? S.of(context).Select_Category
                      : context.read<SendLeaveCubit>().taskDelegation!.text,
              icon: "assets/svgs/summary-expenses(2).svg",
              items: const [
                "ssss2",
                "ssss1",
                "ssss3",
                "ssss4",
                "ssss5",
                "ssss6",
                "ssss7",
                "ssss8",
              ],
              controller: context.read<SendLeaveCubit>().taskDelegation,
            ),
            SizedBox(height: 16.h),
            BuildTextField(
              label: S.of(context).Emergency_Period,
              hint: "+62 82150005000",
              icon: "assets/svgs/summary-expenses(3).svg",
            ),
            SizedBox(height: 16.h),
            BuildTextField(
              label: S.of(context).Leave_Description,
              hint: S.of(context).Enter_Leave_Description,
              icon: null,
              maxLines: 3,
            ),
          ],
        );
      },
    );
  }
}

void showDateRangeBottomSheet(BuildContext context, SendLeaveCubit cubit,
    TextEditingController controller) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      DateTime? startDate;
      DateTime? endDate;

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Leave Duration',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Select Leave Duration'),
                const SizedBox(height: 8),
                Text(
                  startDate != null && endDate != null
                      ? 'Selected: ${startDate!.toString().split(' ')[0]} to ${endDate!.toString().split(' ')[0]}'
                      : 'No dates selected',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                TableCalendar(
                  firstDay: DateTime(DateTime.monthsPerYear),
                  lastDay: DateTime(2030),
                  focusedDay: DateTime.now(),
                  calendarFormat: CalendarFormat.month,
                  rangeSelectionMode: RangeSelectionMode.toggledOn,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  onRangeSelected: (start, end, focusedDay) {
                    setState(() {
                      startDate = start;
                      endDate = end;
                    });
                    cubit.changeDragDownHint(
                      controller,
                      "$startDate:$endDate",
                    );
                    print("$startDate:$endDate");
                  },
                  rangeStartDay: startDate,
                  rangeEndDay: endDate,
                  calendarStyle: const CalendarStyle(
                    rangeHighlightColor: ColorsManager.mainColor1,
                    todayDecoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: ColorsManager.mainColor1,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
                const SizedBox(height: 16),
                LeaveDurationButtons(
                  startDate: startDate,
                  endDate: endDate,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
