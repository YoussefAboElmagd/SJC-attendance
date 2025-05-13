
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/generated/l10n.dart';

class UploadExpensesDoc extends StatelessWidget {
  const UploadExpensesDoc({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendExpensesCubit, SendExpensesState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => _showFilePicker(context),
          child: _buildUploadPlaceholder(context),
        );
      },
    );
  }

  Future<void> _showFilePicker(BuildContext context) async {
    final cubit = context.read<SendExpensesCubit>();
    await cubit.pickMultipleFiles(context);
  }

  Widget _buildUploadPlaceholder(BuildContext context) {
    final s = S.of(context);
    return DottedBorder(
      color: ColorsManager.mainColor1.withOpacity(.9),
      strokeWidth: 1.5,
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      radius: Radius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 28.5.w, vertical: 16.h),
        color: ColorsManager.purple,
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/svgs/upload_icon.svg",
              width: 40.w,
              height: 40.w,
            ),
            SizedBox(height: 8.h),
            Text(
              s.Attachment_text,
              style: TextStyles.font18BlackBold.copyWith(
                color: ColorsManager.mainColor2,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              s.Format_should_be_in_pdf,
              textAlign: TextAlign.center,
              style: TextStyles.font12GreyRegular,
            ),
          ],
        ),
      ),
    );
  }
}
