import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_file_preview.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/select_upload_claim_file.dart';
import 'package:madarj/generated/l10n.dart';
import 'dart:async';
// import 'package:pdf_render/pdf_render.dart';

class UploadClaimDoc extends StatelessWidget {
  const UploadClaimDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendExpensesCubit, SendExpensesState>(
      buildWhen: (previous, current) => current is FileSelected,
      builder: (context, state) {
        File? file;
        if (state is FileSelected) {
          file = state.file;
        }
        return InkWell(
          onTap: () {
            file != null ? () {} : _showFileTypeDialog(context);
          },
          child: state.maybeWhen(
            fileSelected: (file) => BuildFilePreview(file: file),
            orElse: () => _buildUploadPlaceholder(context),
          ),
        );
      },
    );
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
              s.Upload_Claim_Document,
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

Future<void> _showFileTypeDialog(BuildContext context) async {
  final cubit = context.read<SendExpensesCubit>();
  await showDialog(
    context: context,
    builder: (context) => SelectUploadClaimFile(cubit: cubit),
  );
}
// 
// Widget _buildLoadingIndicator() {
//   return Container(
//     height: 150.h,
//     color: Colors.grey[200],
//     child: const Center(child: CircularProgressIndicator()),
//   );
// }

// Widget _buildWordPreview() {
//   return Container(
//     height: 150.h,
//     color: Colors.grey[200],
//     child: Center(
//       child: Icon(Icons.description, size: 50.w, color: Colors.blue),
//     ),
//   );
// }

// Widget _buildUnknownFilePreview() {
//   return Container(
//     height: 150.h,
//     color: Colors.grey[200],
//     child: Center(
//       child: Icon(Icons.insert_drive_file, size: 50.w),
//     ),
//   );
// }