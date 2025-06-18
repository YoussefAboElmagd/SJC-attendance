import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_file_preview.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/upload_task_doc.dart';

class UploadTaskPhotos extends StatelessWidget {
  const UploadTaskPhotos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const UploadExpensesDoc(),
          SizedBox(height: 16.h),
          _buildSelectedFilesList(context),
        ],
      ),
    );
  }

  Widget _buildSelectedFilesList(BuildContext context) {
    return BlocBuilder<SendExpensesCubit, SendExpensesState>(
      buildWhen: (previous, current) =>
          current is MultipleFilesSelected ||
          current is RemoveFile ||
          current is FileValidationError ||
          current is FileSelectionInProgress,
      // current is Initial,
      builder: (context, state) {
        return state.maybeWhen(
          multipleFilesSelected: (files) {
            return Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: files
                  .map(
                    (file) => SizedBox(
                      width: 100.w,
                      child: BuildFilePreview(file: file),
                    ),
                  )
                  .toList(),
            );
          },
          removeFile: (files) {
            return Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: files
                  .map(
                    (file) => SizedBox(
                      width: 100.w,
                      child: BuildFilePreview(file: file),
                    ),
                  )
                  .toList(),
            );
          },
          fileValidationError: (error) {
            return AlertDialog(
              icon: Icon(
                Icons.error,
                color: Colors.red,
                size: 32.w,
              ),
              content: Text(
                error,
                style: TextStyles.font15DarkBlueMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    'Got it',
                    style: TextStyles.font14BlueSemiBold,
                  ),
                ),
              ],
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

// Future<void> _showFileTypeDialog(BuildContext context) async {
//   final cubit = context.read<SendExpensesCubit>();
//   await showDialog(
//     context: context,
//     builder: (context) => SelectUploadClaimFile(cubit: cubit),
//   );
// }
