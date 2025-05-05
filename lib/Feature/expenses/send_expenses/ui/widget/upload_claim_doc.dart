import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/app_button.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/generated/l10n.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
// import 'dart:ui' as ui;
// import 'package:flutter/foundation.dart';
import 'package:pdf_render/pdf_render.dart';

class UploadClaimDoc extends StatelessWidget {
  const UploadClaimDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendExpensesCubit, SendExpensesState>(
      builder: (context, state) {
        File? file;
        if (state is FileSelected) {
          file = state.file;
        }
        return InkWell(
          onTap: () {
            print("file != null ${file != null}");
            print("file == null ${file == null}");
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

class SelectUploadClaimFile extends StatelessWidget {
  const SelectUploadClaimFile({super.key, required this.cubit});
  final SendExpensesCubit cubit;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).select_file_type),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.image),
            title: Text(S.of(context).image_text),
            onTap: () async {
              Navigator.pop(context);
              await cubit.checkAndPickFile(
                context,
                cubit,
                FileType.image,
                cubit.pickImage,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: Text(S.of(context).pdf_document),
            onTap: () async {
              Navigator.pop(context);
              await cubit.checkAndPickFile(
                context,
                cubit,
                FileType.custom,
                cubit.pickPdf,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(S.of(context).word_document),
            onTap: () async {
              Navigator.pop(context);
              await cubit.checkAndPickFile(
                context,
                cubit,
                FileType.custom,
                cubit.pickWordDocument,
              );
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          AppTextButton(
            buttonText: S.of(context).close_button,
            textStyle: TextStyles.font16WhiteSemiBold,
            onPressed: () {
              context.popAlert();
            },
            backgroundColor: ColorsManager.mainColor1,
            hintText: "hintText",
          )
        ],
      ),
    );
  }
}

class BuildFilePreview extends StatelessWidget {
  const BuildFilePreview({super.key, required this.file});
  final File file;
  @override
  Widget build(BuildContext context) {
    final extension = file.path.split('.').last.toLowerCase();
    final isImage = ['jpg', 'jpeg', 'png'].contains(extension);
    final isPdf = extension == 'pdf';
    final isWord = ['doc', 'docx'].contains(extension);
    return DottedBorder(
      color: ColorsManager.mainColor1.withOpacity(.9),
      strokeWidth: 1.5,
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      radius: Radius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(8.w),
        color: ColorsManager.purple,
        child: Column(
          children: [
            if (isImage)
              Image.file(
                file,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            else if (isPdf)
              FutureBuilder<Widget>(
                future: _buildPdfPreview(file),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data ?? _buildPdfFallback();
                  }
                  return _buildLoadingIndicator();
                },
              )
            else if (isWord)
              _buildWordPreview()
            else
              _buildUnknownFilePreview(),
            SizedBox(height: 8.h),
            Text(
              file.path.split('/').last,
              style: TextStyles.font14BlackSemiBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

Future<Widget> _buildPdfPreview(File file) async {
  try {
    final document = await PdfDocument.openFile(file.path);
    if (document.pageCount == 0) return _buildPdfFallback();

    final page = await document.getPage(1);
    final pageImage = await page.render(width: 300, height: 300);
    final image = await pageImage.createImageDetached();
    await document.dispose();

    return RawImage(
      image: image,
      width: double.infinity,
      height: 150.h,
      fit: BoxFit.contain,
    );
  } catch (e) {
    debugPrint('PDF rendering error: $e');
    return _buildPdfFallback();
  }
}

Widget _buildLoadingIndicator() {
  return Container(
    height: 150.h,
    color: Colors.grey[200],
    child: const Center(child: CircularProgressIndicator()),
  );
}

Widget _buildPdfFallback() {
  return Container(
    height: 150.h,
    color: Colors.grey[200],
    child: Center(child: Icon(Icons.picture_as_pdf, size: 50.w)),
  );
}

Widget _buildWordPreview() {
  return Container(
    height: 150.h,
    color: Colors.grey[200],
    child: Center(
      child: Icon(Icons.description, size: 50.w, color: Colors.blue),
    ),
  );
}

Widget _buildUnknownFilePreview() {
  return Container(
    height: 150.h,
    color: Colors.grey[200],
    child: Center(
      child: Icon(Icons.insert_drive_file, size: 50.w),
    ),
  );
}

Future<void> _showFileTypeDialog(BuildContext context) async {
  final cubit = context.read<SendExpensesCubit>();
  await showDialog(
    context: context,
    builder: (context) => SelectUploadClaimFile(cubit: cubit),
  );
}
