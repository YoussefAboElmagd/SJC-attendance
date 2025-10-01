import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:pdfx/pdfx.dart';

class BuildFilePreview extends StatelessWidget {
  const BuildFilePreview({super.key, required this.file});
  final File file;

  @override
  Widget build(BuildContext context) {
    final extension = file.path.split('.').last.toLowerCase();
    final isImage = ['jpg', 'jpeg', 'png'].contains(extension);
    final isPdf = extension == 'pdf';
    final isWord = ['doc', 'docx'].contains(extension);
    final cubit = context.read<SendExpensesCubit>();

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
                  _buildPdfPreview(file)
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

  Widget _buildPdfPreview(File file) {
    return FutureBuilder<PdfDocument>(
      future: PdfDocument.openFile(file.path),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return _buildPdfFallback();
          }
          final controller = PdfController(
            document: Future.value(snapshot.data!),
            initialPage: 1,
          );
          return SizedBox(
            height: 150.h,
            child: PdfView(
              controller: controller,
              renderer: (PdfPage page) => page.render(
                width: page.width * 2,
                height: page.height * 2,
                format: PdfPageImageFormat.jpeg,
                backgroundColor: '#FFFFFF',
              ),
            ),
          );
        } else {
          return _buildLoadingIndicator();
        }
      },
    );
  }
  // Widget _buildPdfPreview(File file) {
  //   return FutureBuilder<PdfDocument>(
  //     future: PdfDocument.openFile(file.path),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done &&
  //           snapshot.hasData) {
  //         final controller = PdfController(
  //           document: snapshot.data!,
  //           initialPage: 1,
  //         );
  //         return SizedBox(
  //           height: 150.h,
  //           child: PdfView(
  //             controller: controller,
  //             renderer: (PdfPage page) => page.render(
  //               width: page.width * 2,
  //               height: page.height * 2,
  //               format: PdfPageImageFormat.jpeg,
  //               backgroundColor: '#FFFFFF',
  //             ),
  //             // pageNumber: 1,
  //           ),
  //         );
  //       } else if (snapshot.hasError) {
  //         return _buildPdfFallback();
  //       } else {
  //         return _buildLoadingIndicator();
  //       }
  //     },
  //   );
  // }

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
      child: Center(child: Icon(Icons.insert_drive_file, size: 50.w)),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 150.h,
      color: Colors.grey[200],
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

// import 'dart:io';

// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Core/themes/colors.dart';
// import 'package:madarj/Core/themes/styles.dart';
// import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
// // import 'package:pdf_render/pdf_render.dart';

// class BuildFilePreview extends StatelessWidget {
//   const BuildFilePreview({super.key, required this.file});
//   final File file;
//   @override
//   Widget build(BuildContext context) {
//     final extension = file.path.split('.').last.toLowerCase();
//     final isImage = ['jpg', 'jpeg', 'png'].contains(extension);
//     final isPdf = extension == 'pdf';
//     final isWord = ['doc', 'docx'].contains(extension);
//     final cubit = context.read<SendExpensesCubit>();

//     return Stack(
//       children: [
//         DottedBorder(
//           color: ColorsManager.mainColor1.withOpacity(.9),
//           strokeWidth: 1.5,
//           dashPattern: const [6, 4],
//           borderType: BorderType.RRect,
//           radius: Radius.circular(12.r),
//           child: Container(
//             padding: EdgeInsets.all(8.w),
//             color: ColorsManager.purple,
//             child: Column(
//               children: [
//                 if (isImage)
//                   Image.file(
//                     file,
//                     height: 100.h,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   )
//                 // else if (isPdf)
//                 //   FutureBuilder<Widget>(
//                 //     future: _buildPdfPreview(file),
//                 //     builder: (context, snapshot) {
//                 //       if (snapshot.connectionState == ConnectionState.done) {
//                 //         return snapshot.data ?? _buildPdfFallback();
//                 //       }
//                 //       return _buildLoadingIndicator();
//                 //     },
//                 //   )
//                 else if (isWord)
//                   _buildWordPreview()
//                 else
//                   _buildUnknownFilePreview(),
//                 SizedBox(height: 8.h),
//                 Text(
//                   file.path.split('/').last,
//                   style: TextStyles.font14BlackSemiBold,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: 4,
//           right: 4,
//           child: GestureDetector(
//             onTap: () {
//               print(file);
//               cubit.removeFile(file);
//             },
//             child: Container(
//               padding: EdgeInsets.all(4.w),
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Icon(Icons.close, color: Colors.white, size: 20.w),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPdfFallback() {
//     return Container(
//       height: 150.h,
//       color: Colors.grey[200],
//       child: Center(child: Icon(Icons.picture_as_pdf, size: 50.w)),
//     );
//   }

//   // Future<Widget> _buildPdfPreview(File file) async {
//   //   try {
//   //     final document = await PdfDocument.openFile(file.path);
//   //     if (document.pageCount == 0) return _buildPdfFallback();

//   //     final page = await document.getPage(1);
//   //     final pageImage = await page.render(width: 300, height: 300);
//   //     final image = await pageImage.createImageDetached();
//   //     await document.dispose();

//   //     return RawImage(
//   //       image: image,
//   //       width: double.infinity,
//   //       height: 150.h,
//   //       fit: BoxFit.contain,
//   //     );
//   //   } catch (e) {
//   //     debugPrint('PDF rendering error: $e');
//   //     return _buildPdfFallback();
//   //   }
//   // }

//   Widget _buildWordPreview() {
//     return Container(
//       height: 150.h,
//       color: Colors.grey[200],
//       child: Center(
//         child: Icon(Icons.description, size: 50.w, color: Colors.blue),
//       ),
//     );
//   }


// Widget _buildUnknownFilePreview() {
//   return Container(
//     height: 150.h,
//     color: Colors.grey[200],
//     child: Center(
//       child: Icon(Icons.insert_drive_file, size: 50.w),
//     ),
//   );
// }


//   Widget _buildLoadingIndicator() {
//     return Container(
//       height: 150.h,
//       color: Colors.grey[200],
//       child: const Center(child: CircularProgressIndicator()),
//     );
//   }
// }
