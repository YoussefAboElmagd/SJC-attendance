import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/build_text_field.dart';
// import 'package:madarj/Feature/expenses/send_expenses/ui/widget/select_upload_claim_file.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/widget/show_buttom_sheet_form.dart';
import 'package:madarj/Feature/leave/send_leave/ui/widgets/custom_bottom_sheet.dart';
import 'package:madarj/Feature/tasks/send_tasks/logic/cubit/send_tasks_cubit.dart';
import 'package:madarj/Feature/tasks/send_tasks/logic/cubit/send_tasks_state.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:file_picker/file_picker.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/widgets/app_button.dart';

class SendTasksBody extends StatelessWidget {
  const SendTasksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<SendTasksCubit, SendTasksState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // LeaveClaim(),
                    SendLeaveForms(),
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

class SendLeaveForms extends StatelessWidget {
  const SendLeaveForms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendTasksCubit, SendTasksState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            const UploadTaskPhotos(),
            const SizedBox(height: 16),
            BuildTextField(
              label: S.of(context).Task_Title,
              hint: S.of(context).Enter_Task_Title,
              icon: "assets/svgs/summary-expenses(3).svg",
            ),
            SizedBox(height: 16.h),
            BuildTextField(
              label: S.of(context).Task_Description,
              hint: S.of(context).Enter_Task_Description,
              icon: null,
              maxLines: 3,
            ),
            BuildDropdown(
              label: S.of(context).Assign_To,
              icon: "assets/svgs/summary-expenses(1).svg",
              hint:
                  context.read<SendTasksCubit>().assignTo?.text.isEmpty ?? true
                      ? S.of(context).Select_Member
                      : context.read<SendTasksCubit>().assignTo!.text,
              items: const [
                "Ivankov - Sr Front End Developer",
                "Brahm - Mid Front End Developer",
                "Alice - Sr Front End Developer",
                "Jeane - Jr Front End Developer",
                "Claudia - Jr Front End Developer",
                "helmy - sr fotware enginner",
                "dolaa - sr fotware enginner",
                "3laa - sr fotware enginner",
                "bombo - sr fotware enginner",
              ],
              controller: context.read<SendTasksCubit>().assignTo,
            ),
            SizedBox(height: 16.h),
            BuildDropdown(
              label: S.of(context).Priority,
              hint: context
                          .read<SendTasksCubit>()
                          .priorityControl
                          ?.text
                          .isEmpty ??
                      true
                  ? S.of(context).Select_Priority
                  : context.read<SendTasksCubit>().priorityControl!.text,
              icon: "assets/svgs/summary-expenses(2).svg",
              items: const [
                "Low",
                "Medium",
                "High",
              ],
              controller: context.read<SendTasksCubit>().priorityControl,
            ),
            SizedBox(height: 16.h),
            BuildDropdown(
              label: S.of(context).Tags,
              hint: context.read<SendTasksCubit>().tagsControl?.text.isEmpty ??
                      true
                  ? S.of(context).Select_tag
                  : context.read<SendTasksCubit>().tagsControl!.text,
              icon: "assets/svgs/summary-expenses(2).svg",
              items: const [
                "Very Easy (Less Than a Day)",
                "Easy (A Day)",
                "Moderate (3 Days)",
                "Intermediate (5 Days)",
                "Advanced (1 Week)",
              ],
              controller: context.read<SendTasksCubit>().tagsControl,
            ),
            SizedBox(height: 16.h),
          ],
        );
      },
    );
  }
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
    var leaveCubit = context.read<SendTasksCubit>();

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
      TextEditingController? textEditingController, SendTasksCubit cubit) {
    final leaveCubit = context.read<SendTasksCubit>();

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
          value: leaveCubit,
          child: CustomBottomSheet(
            label: label,
            hint: hint,
            items: items,
            textEditingController: textEditingController,
            onTap: onTap2,
            cubit: leaveCubit,
          ),
        );
      },
    );
  }
}

class LeaveClaim extends StatelessWidget {
  const LeaveClaim({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).Attachment_text,
          style: TextStyles.font18BlackSemiBold,
        ),
        SizedBox(height: 4.h),
        Text(
          S.of(context).Format_should_MB,
          style: TextStyles.font14GreyRegular,
        ),
      ],
    );
  }
}

class UploadTaskPhotos extends StatelessWidget {
  const UploadTaskPhotos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const UploadTaskDoc(),
          SizedBox(height: 16.h),
          _buildSelectedFilesList(context),
        ],
      ),
    );
  }

  Widget _buildSelectedFilesList(BuildContext context) {
    return BlocBuilder<SendTasksCubit, SendTasksState>(
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

class UploadTaskDoc extends StatelessWidget {
  const UploadTaskDoc({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendTasksCubit, SendTasksState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => _showFilePicker(context),
          child: _buildUploadPlaceholder(context),
        );
      },
    );
  }

  Future<void> _showFilePicker(BuildContext context) async {
    final cubit = context.read<SendTasksCubit>();
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

Future<void> _showFileTypeDialog(BuildContext context) async {
  final cubit = context.read<SendTasksCubit>();
  await showDialog(
    context: context,
    builder: (context) => SelectUploadClaimFile(cubit: cubit),
  );
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
    final cubit = context.read<SendTasksCubit>();

    return Stack(
      children: [
        DottedBorder(
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
                    height: 100.h,
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
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              print(file);
              cubit.removeFile(file);
            },
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.close, color: Colors.white, size: 20.w),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPdfFallback() {
    return Container(
      height: 150.h,
      color: Colors.grey[200],
      child: Center(child: Icon(Icons.picture_as_pdf, size: 50.w)),
    );
  }
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

Widget _buildWordPreview() {
  return Container(
    height: 150.h,
    color: Colors.grey[200],
    child: Center(
      child: Icon(Icons.description, size: 50.w, color: Colors.blue),
    ),
  );
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

Widget _buildPdfFallback() {
  return Container(
    height: 150.h,
    color: Colors.grey[200],
    child: Center(child: Icon(Icons.picture_as_pdf, size: 50.w)),
  );
}

Widget _buildLoadingIndicator() {
  return Container(
    height: 150.h,
    color: Colors.grey[200],
    child: const Center(child: CircularProgressIndicator()),
  );
}

class SelectUploadClaimFile extends StatelessWidget {
  SelectUploadClaimFile({super.key, required this.cubit});
  var cubit;
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
                cubit.pickImages,
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
                cubit.pickPdfs,
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
                cubit.pickWordDocuments,
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

        // List<File> files = [
        //   context.read<SendTasksCubit>().file1!,
        //   context.read<SendTasksCubit>().file2!,
        //   context.read<SendTasksCubit>().file3!,
        // ];
  // Widget _buildUploadPlaceholder(BuildContext context) {
  //   final s = S.of(context);
  //   return DottedBorder(
  //     color: ColorsManager.mainColor1.withOpacity(.9),
  //     strokeWidth: 1.5,
  //     dashPattern: const [6, 4],
  //     borderType: BorderType.RRect,
  //     radius: Radius.circular(12.r),
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 28.5.w, vertical: 16.h),
  //       color: ColorsManager.purple,
  //       child: Column(
  //         children: [
  //           SvgPicture.asset(
  //             "assets/svgs/upload_icon.svg",
  //             width: 40.w,
  //             height: 40.w,
  //           ),
  //           SizedBox(height: 8.h),
  //           Text(
  //             s.Attachment_text,
  //             style: TextStyles.font18BlackBold.copyWith(
  //               color: ColorsManager.mainColor2,
  //             ),
  //           ),
  //           SizedBox(height: 4.h),
  //           Text(
  //             s.Format_should_be_in_pdf,
  //             textAlign: TextAlign.center,
  //             style: TextStyles.font12GreyRegular,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //   // return DottedBorder(
  //   //   color: ColorsManager.mainColor2.withOpacity(.3),
  //   //   strokeWidth: 1.5,
  //   //   dashPattern: const [6, 4],
  //   //   borderType: BorderType.RRect,
  //   //   radius: Radius.circular(12.r),
  //   //   child: Container(
  //   //     padding: EdgeInsets.all(8.w),
  //   //     decoration: BoxDecoration(
  //   //       borderRadius: BorderRadius.circular(12.r),
  //   //       color: ColorsManager.purple,
  //   //     ),
  //   //     width: 90.w,
  //   //     height: 80.h,
  //   //     child: SizedBox(
  //   //       width: 10.w,
  //   //       height: 10.h,
  //   //       child: const Image(
  //   //         color: ColorsManager.mainColor1,
  //   //         image: AssetImage(
  //   //           "assets/images/upload.png",
  //   //         ),
  //   //       ),
  //   //     ),
  //   //   ),
  //   // );
  // }

    // return DottedBorder(
    //   color: ColorsManager.mainColor1.withOpacity(.9),
    //   strokeWidth: 1.5,
    //   dashPattern: const [6, 4],
    //   borderType: BorderType.RRect,
    //   radius: Radius.circular(12.r),
    //   child: Container(
    //     padding: EdgeInsets.all(8.w),
    //     color: ColorsManager.purple,
    //     child: Column(
    //       children: [
    //         if (isImage)
    //           Image.file(
    //             file,
    //             height: 150.h,
    //             width: double.infinity,
    //             fit: BoxFit.cover,
    //           )
    //         else if (isPdf)
    //           FutureBuilder<Widget>(
    //             future: _buildPdfPreview(file),
    //             builder: (context, snapshot) {
    //               if (snapshot.connectionState == ConnectionState.done) {
    //                 return snapshot.data ?? _buildPdfFallback();
    //               }
    //               return _buildLoadingIndicator();
    //             },
    //           )
    //         else if (isWord)
    //           _buildWordPreview()
    //         else
    //           _buildUnknownFilePreview(),
    //         SizedBox(height: 8.h),
    //         Text(
    //           file.path.split('/').last,
    //           style: TextStyles.font14BlackSemiBold,
    //           maxLines: 1,
    //           overflow: TextOverflow.ellipsis,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
// class UploadTaskPhotos extends StatelessWidget {
//   const UploadTaskPhotos({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         children: [
//           const UploadTaskDoc(),
//           SizedBox(height: 16.h),
//           _buildSelectedFilesList(context),
//         ],
//       ),
//     );
//     // return SizedBox(
//     //   // width: 90.w,
//     //   // height: 80.h,

//     //   child: Row(
//     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //     children: List.generate(
//     //       3,
//     //       (index) => ,

//     //     ),
//     //   ),
//     // );
//   }

//   Widget _buildSelectedFilesList(BuildContext context) {
//     return BlocBuilder<SendTasksCubit, SendTasksState>(
//       builder: (context, state) {
//         final files = state.maybeMap(
//           multipleFilesSelected: (state) => state.files,
//           orElse: () => <File>[],
//         );

//         if (files.isEmpty) return const SizedBox();

//         return Column(
//           children: [
//             ...files
//                 .map((file) => Padding(
//                       padding: EdgeInsets.only(bottom: 8.h),
//                       child: BuildFilePreview(file: file),
//                     ))
//                 .toList(),
//           ],
//         );
//       },
//     );
//   }
// }

