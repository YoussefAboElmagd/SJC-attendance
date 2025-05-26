import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/show_buttom_sheet_form.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/custom_bottom_sheet.dart';

class BuildDropdown extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? icon;
  final ValueChanged<String>? onItemSelected;
  final Function()? onTap;
  TextEditingController? controller;
  TextEditingController? controllerId;
  final void Function()? onTap2;
  final Map<String, String>? mapDrop;

  BuildDropdown({
    super.key,
    this.label,
    this.hint,
    this.icon,
    this.onItemSelected,
    this.controller,
    this.controllerId,
    this.onTap,
    this.onTap2,
    this.mapDrop,
  });

  @override
  Widget build(BuildContext context) {
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
          onTap: onTap ??
              () => _showBottomSheet(
                    context,
                    controller,
                    controllerId,
                    mapDrop,
                  ),
        ),
      ],
    );
  }

  void _showBottomSheet(
    BuildContext context,
    TextEditingController? textEditingController,
    TextEditingController? id,
    Map<String, String>? mapDrop,
  ) {
    var cubit = context.read<SendExpensesCubit>();
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
          value: cubit,
          child: CustomBottomSheet(
            id: id,
            itemsId: mapDrop!.keys.toList(),
            label: label,
            hint: hint,
            items: mapDrop.values.toList(),
            textEditingController: textEditingController,
            onTap: onTap2,
            itemsMap: mapDrop,
            cubit: cubit,
          ),
        );
      },
    );
  }
}
