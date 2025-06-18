import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/drop_down_list_by_id.dart';
import 'package:madarj/Feature/leave/send_leave/data/model/timeoff_type_model.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_state.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/Leave_build_drop_down.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/leave_duration_buttons.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:table_calendar/table_calendar.dart';

class SendLeaveForms extends StatelessWidget {
  const SendLeaveForms({super.key, required this.timeoffTypesResponse});
  final TimeoffTypesResponse timeoffTypesResponse;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendLeaveCubit, SendLeaveState>(
      builder: (context, state) {
        return Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).Leave_Category,
                  style: TextStyles.font16BlackSemiBold,
                ),
                SizedBox(height: 8.h),
                DropDownListById(
                  hintTextStyle: TextStyles.font14Grey,
                  textStyle: TextStyles.font16MainColorBold,
                  text: S.of(context).Leave_Category,
                  list: timeoffTypesResponse.data ?? [],
                  selectedValue: "",
                  onChanged: (value) {
                    if (value != null && timeoffTypesResponse.data != null) {
                      final selectedItem = timeoffTypesResponse.data!
                          .firstWhere(
                            (item) => item.id.toString() == value,
                            orElse: () => timeoffTypesResponse.data!.first,
                          );
                      context.read<SendLeaveCubit>().leaveCtegory!.text =
                          selectedItem.name ?? "";
                      context.read<SendLeaveCubit>().leaveCtegoryId!.text = value;
                    }
                  },
                  validator: AppConstants.dropDownListValidation(
                    context: context,
                  ),
                ),
              ],
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
                        .toFormattedDateRange(isArabic: AppConstants.isArabic),
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
          ],
        );
      },
    );
  }
}

void showDateRangeBottomSheet(
  BuildContext context,
  SendLeaveCubit cubit,
  TextEditingController controller,
) {
  // Initialize local variables with cubit's current dates
  DateTime? localStartDate = cubit.startDate;
  DateTime? localEndDate = cubit.endDate;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: cubit, // Provide the cubit to the modal
        child: StatefulBuilder(
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
                    localStartDate != null && localEndDate != null
                        ? 'Selected: ${localStartDate!.toString().split(' ')[0]} to ${localEndDate!.toString().split(' ')[0]}'
                        : 'No dates selected',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TableCalendar(
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2030),
                    focusedDay: DateTime.now(),
                    calendarFormat: CalendarFormat.month,
                    rangeSelectionMode: RangeSelectionMode.toggledOn,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    onRangeSelected: (start, end, focusedDay) {
                      setState(() {
                        localStartDate = start;
                        localEndDate = end;
                      });
                      cubit.startDate = start;
                      cubit.endDate = end;
                      print("Selected range: $localStartDate to $localEndDate");
                    },
                    rangeStartDay: localStartDate,
                    rangeEndDay: localEndDate,
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
                    startDate: localStartDate,
                    endDate: localEndDate,
                    controller: controller,
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
// void showDateRangeBottomSheet(
//   BuildContext context,
//   SendLeaveCubit cubit,
//   TextEditingController controller,
// ) {
//   DateTime? localStartDate = cubit.startDate;
//   DateTime? localEndDate = cubit.endDate;

//   showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     isScrollControlled: true,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16.0,
//               vertical: 16.0,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Leave Duration',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text('Select Leave Duration'),
//                 const SizedBox(height: 8),
//                 Text(
//                   localStartDate != null && localEndDate != null
//                       ? 'Selected: ${localStartDate!.toString().split(' ')[0]} to ${localEndDate!.toString().split(' ')[0]}'
//                       : 'No dates selected',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 TableCalendar(
//                   firstDay:
//                       DateTime.now(), // Changed from DateTime(DateTime.monthsPerYear)
//                   lastDay: DateTime(2030),
//                   focusedDay: DateTime.now(),
//                   calendarFormat: CalendarFormat.month,
//                   rangeSelectionMode: RangeSelectionMode.toggledOn,
//                   startingDayOfWeek: StartingDayOfWeek.sunday,
//                   onRangeSelected: (start, end, focusedDay) {
//                     setState(() {
//                       localStartDate = start;
//                       localEndDate = end;
//                     });
//                     // Don't update cubit here, wait for submit button
//                     print("Selected range: $localStartDate to $localEndDate");
//                   },
//                   rangeStartDay: localStartDate,
//                   rangeEndDay: localEndDate,
//                   calendarStyle: const CalendarStyle(
//                     rangeHighlightColor: ColorsManager.mainColor1,
//                     todayDecoration: BoxDecoration(
//                       color: Colors.black,
//                       shape: BoxShape.circle,
//                     ),
//                     selectedDecoration: BoxDecoration(
//                       color: ColorsManager.mainColor1,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   headerStyle: const HeaderStyle(
//                     formatButtonVisible: false,
//                     titleCentered: true,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 LeaveDurationButtons(
//                   startDate: localStartDate,
//                   endDate: localEndDate,
//                   controller: controller,
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }

// void showDateRangeBottomSheet(
//   BuildContext context,
//   SendLeaveCubit cubit,
//   TextEditingController controller,
// ) {
//   showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     isScrollControlled: true,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16.0,
//               vertical: 16.0,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Leave Duration',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text('Select Leave Duration'),
//                 const SizedBox(height: 8),
//                 Text(
//                   cubit.startDate != null && cubit.endDate != null
//                       ? 'Selected: ${cubit.startDate!.toString().split(' ')[0]} to ${cubit.endDate!.toString().split(' ')[0]}'
//                       : 'No dates selected',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 TableCalendar(
//                   firstDay: DateTime(DateTime.monthsPerYear),
//                   lastDay: DateTime(2030),
//                   focusedDay: DateTime.now(),
//                   calendarFormat: CalendarFormat.month,
//                   rangeSelectionMode: RangeSelectionMode.toggledOn,
//                   startingDayOfWeek: StartingDayOfWeek.sunday,
//                   onRangeSelected: (start, end, focusedDay) {
//                     setState(() {
//                       cubit.startDate = start;
//                       cubit.endDate = end;
//                     });
//                     cubit.changeDragDownHint(
//                       controller,
//                       "${cubit.startDate}:${cubit.endDate}",
//                     );
//                     print("${cubit.startDate}:${cubit.endDate}");
//                   },
//                   rangeStartDay: cubit.startDate,
//                   rangeEndDay: cubit.endDate,
//                   calendarStyle: const CalendarStyle(
//                     rangeHighlightColor: ColorsManager.mainColor1,
//                     todayDecoration: BoxDecoration(
//                       color: Colors.black,
//                       shape: BoxShape.circle,
//                     ),
//                     selectedDecoration: BoxDecoration(
//                       color: ColorsManager.mainColor1,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   headerStyle: const HeaderStyle(
//                     formatButtonVisible: false,
//                     titleCentered: true,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 LeaveDurationButtons(
//                   startDate: cubit.startDate,
//                   endDate: cubit.endDate,
//                   controller: null,
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }
