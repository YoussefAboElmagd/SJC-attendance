import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/bottom_sheet.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/show_buttom_sheet_form.dart';

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
          onTap: onTap ?? () => _showBottomSheet(context, controller),
        ),
      ],
    );
  }

  void _showBottomSheet(
      BuildContext context, TextEditingController? textEditingController) {
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
        );
      },
    );
  }
}
