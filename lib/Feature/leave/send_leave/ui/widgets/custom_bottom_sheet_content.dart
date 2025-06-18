import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class CustomBottomSheetContent extends StatelessWidget {
  final String? label;
  final String? hint;
  final Widget listContent;
  final Widget buttonsRow;

  const CustomBottomSheetContent({
    super.key,
    this.label,
    this.hint,
    required this.listContent,
    required this.buttonsRow,
  });

  @override
  Widget build(BuildContext context) {
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
          listContent,
          SizedBox(height: 16.h),
          buttonsRow,
        ],
      ),
    );
  }
}
