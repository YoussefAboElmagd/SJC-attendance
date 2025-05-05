import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_text_field.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_state.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/show_buttom_sheet_form.dart';

import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/widgets/app_button.dart';

class SendLeaveBody extends StatelessWidget {
  const SendLeaveBody({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<SendLeaveCubit, SendLeaveState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FillLeave(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      S.of(context).Fill_Claim_Information,
                      style: TextStyles.font18BlackSemiBold,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      S.of(context).Information_about_claim_details,
                      style: TextStyles.font14GreyRegular,
                    ),
                    SizedBox(height: 20.h),
                    BuildDropdown(
                      label: S.of(context).Leave_Category,
                      // hint: S.of(context).Select_Category,
                      icon: "assets/svgs/summary-expenses(1).svg",
                      hint: context
                                  .read<SendLeaveCubit>()
                                  .leaveCtegory
                                  ?.text
                                  .isEmpty ??
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
                      hint: context
                                  .read<SendLeaveCubit>()
                                  .leaveDuration
                                  ?.text
                                  .isEmpty ??
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
                      hint: context
                                  .read<SendLeaveCubit>()
                                  .taskDelegation
                                  ?.text
                                  .isEmpty ??
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
                ),
              ),
              SizedBox(height: 40.h),
            ],
          );
        },
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  CustomBottomSheet(
      {super.key,
      required this.label,
      required this.hint,
      required this.items,
      required this.textEditingController,
      this.onTap,
      required this.cubit});
  final SendLeaveCubit? cubit;
  final String? label;
  final String? hint;
  final List<String> items;
  TextEditingController? textEditingController;
  final void Function()? onTap;
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    // return StatefulBuilder(
    // builder: (BuildContext context, StateSetter setState) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? 'Select Option',
            style: TextStyles.font16BlackSemiBold.copyWith(
              color: const Color(0xFF2A3183),
            ),
          ),
          Text(
            hint ?? S.of(context).Select_Expense_Category,
            style: TextStyles.font14GreyRegular,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 285.h,
            child: Scrollbar(
              thumbVisibility: true,
              radius: Radius.circular(
                3.r,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: items.length,
                separatorBuilder: (_, __) => SizedBox(
                  height: 10.h,
                ),
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.w,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      child: InkWell(
                        onTap: onTap ??
                            () {
                              cubit != null
                                  ? cubit!.changeDragDownHint(
                                      textEditingController,
                                      selectedItem,
                                    )
                                  : () {};
                            },
                        child: Row(
                          children: [
                            Text(
                              items[index],
                              style: TextStyles.font16BlackSemiBold,
                            ),
                            const Spacer(),
                            Radio<String>(
                              value: items[index],
                              groupValue: selectedItem,
                              onChanged: (value) {
                                cubit != null
                                    ? cubit!.changeDragDownHint(
                                        textEditingController,
                                        selectedItem,
                                      )
                                    : () {};
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppTextButton(
                  hintText: S.of(context).Close_Message,
                  buttonText: S.of(context).Close_Message,
                  textStyle: TextStyles.font16GreyNormal,
                  borderRadius: 30.r,
                  onPressed: () {
                    context.pop();
                  },
                  backgroundColor: ColorsManager.white,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: AppTextButton(
                  hintText: S.of(context).Submit_Date,
                  buttonText: S.of(context).Submit_Date,
                  textStyle: selectedItem == null || selectedItem == ""
                      ? TextStyles.font16WhiteNormal
                      : TextStyles.font16WhiteSemiBold,
                  onPressed: () {
                    context.pop();
                  },
                  backgroundColor: selectedItem == null || selectedItem == ""
                      ? ColorsManager.grey
                      : ColorsManager.mainColor1,
                  borderRadius: 30.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FillLeave extends StatelessWidget {
  const FillLeave({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF3B3B98),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).Fill_Leave_Information,
            style: TextStyles.font18WhiteSemiBold,
          ),
          SizedBox(height: 4.h),
          Text(
            S.of(context).Information_leave_details,
            style: TextStyles.font14GreyRegular,
          ),
        ],
      ),
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

class BuildDropdown extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? icon;
  final List<String> items;
  final ValueChanged<String>? onItemSelected;
  final Function()? onTap;
  TextEditingController? controller;
  final void Function()? onTap2;

  BuildDropdown({
    super.key,
    this.label,
    this.hint,
    this.icon,
    required this.items,
    this.onItemSelected,
    this.controller,
    this.onTap,
    this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    var leaveCubit = context.read<SendLeaveCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyles.font16BlackSemiBold,
          ),
        SizedBox(height: 8.h),
        ShowButtomSheetForm(
          hint: hint,
          icon: icon,
          onTap:
              onTap ?? () => _showBottomSheet(context, controller, leaveCubit),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context,
      TextEditingController? textEditingController, SendLeaveCubit cubit) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            16.r,
          ),
        ),
      ),
      builder: (context) {
        return CustomBottomSheet(
          label: label,
          hint: hint,
          items: items,
          textEditingController: textEditingController,
          onTap: onTap2,
          cubit: cubit,
        );
      },
    );
  }
}

class LeaveDurationButtons extends StatelessWidget {
  const LeaveDurationButtons({
    super.key,
    this.startDate,
    this.endDate,
  });

  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // cubit.changeDragDownHint(
              //         controller,
              //         "$startDate:$endDate",
              //       );
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: startDate != null && endDate != null
                  ? ColorsManager.mainColor1
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              S.of(context).Submit_Date,
              style: startDate != null && endDate != null
                  ? TextStyles.font16WhiteSemiBold
                  : TextStyles.font16BlackSemiBold.copyWith(
                      color: ColorsManager.mainColor1,
                    ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              S.of(context).close_button,
              style: TextStyles.font16BlackSemiBold.copyWith(
                color: ColorsManager.mainColor1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
