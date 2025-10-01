
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/show_buttom_sheet_form.dart';
// import 'package:madarj/Feature/expenses/send_expenses/ui/widget/show_buttom_sheet_form.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/custom_bottom_sheet.dart';
import 'package:madarj/Feature/tasks/send_tasks/logic/cubit/send_tasks_cubit.dart';

class BuildDropdownTasks extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? icon;
  final List<String> items;
  final ValueChanged<String>? onItemSelected;
  final Function()? onTap;
  TextEditingController? controller;
  final void Function()? onTap2;

  BuildDropdownTasks({
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
    var taskCubit = context.read<SendTasksCubit>();

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
              onTap ?? () => _showBottomSheet(context, controller, taskCubit),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context,
      TextEditingController? textEditingController, SendTasksCubit cubit) {
    final taskCubit = context.read<SendTasksCubit>();

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
        return BlocProvider.value(
          value: taskCubit,
          child: CustomBottomSheet(
            label: label,
            hint: hint,
            items: items,
            textEditingController: textEditingController,
            onTap: onTap2,
            cubit: taskCubit,
          ),
        );
      },
    );
  }
}