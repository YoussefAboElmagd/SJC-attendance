import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:pdf_render/pdf_render.dart';

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
