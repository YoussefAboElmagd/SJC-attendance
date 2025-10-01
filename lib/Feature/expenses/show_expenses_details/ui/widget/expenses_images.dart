// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/logic/cubit/expenses_details_cubit.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/logic/cubit/expenses_details_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

class ExpensesImages extends StatelessWidget {
  const ExpensesImages({super.key, this.data});
  final ExpenseDetailsResponse? data;

  bool _isImage(Attachment attachment) {
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp'];
    final mimetype = attachment.mimetype?.toLowerCase() ?? '';
    final name = attachment.name?.toLowerCase() ?? '';

    // Check by mimetype first
    if (mimetype.startsWith('image/')) return true;

    // Check by file extension
    return imageExtensions.any((ext) => name.endsWith(ext));
  }

  bool _isPdf(Attachment attachment) {
    final mimetype = attachment.mimetype?.toLowerCase() ?? '';
    final name = attachment.name?.toLowerCase() ?? '';

    return mimetype == 'application/pdf' || name.endsWith('.pdf');
  }

  bool _isWord(Attachment attachment) {
    final mimetype = attachment.mimetype?.toLowerCase() ?? '';
    final name = attachment.name?.toLowerCase() ?? '';

    return mimetype.contains('word') ||
        mimetype.contains('document') ||
        name.endsWith('.doc') ||
        name.endsWith('.docx');
  }

  IconData _getFileIcon(Attachment attachment) {
    if (_isPdf(attachment)) return Icons.picture_as_pdf;
    if (_isWord(attachment)) return Icons.description;
    return Icons.insert_drive_file;
  }

  Uint8List? _decodeBase64(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;
    try {
      return base64Decode(base64String);
    } catch (e) {
      print('Error decoding base64: $e');
      return null;
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isGranted) {
        return true;
      }

      // For Android 11+ (API 30+)
      if (await Permission.manageExternalStorage.request().isGranted) {
        return true;
      }

      // Fallback for older Android versions
      if (await Permission.storage.request().isGranted) {
        return true;
      }

      return false;
    }
    return true; // iOS doesn't need explicit storage permission for app documents
  }

  Future<String?> _getDownloadPath() async {
    try {
      if (Platform.isAndroid) {
        // Try to get Downloads directory
        Directory? directory = Directory('/storage/emulated/0/Download');
        if (await directory.exists()) {
          return directory.path;
        }

        // Fallback to external storage
        directory = await getExternalStorageDirectory();
        return directory?.path;
      } else {
        // iOS - use app documents directory
        final directory = await getApplicationDocumentsDirectory();
        return directory.path;
      }
    } catch (e) {
      print('Error getting download path: $e');
      return null;
    }
  }

  // Helper method to safely show SnackBar
  void _showSnackBar(
    BuildContext context,
    String message, {
    SnackBarAction? action,
  }) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
          action: action,
        ),
      );
    }
  }

  Future<void> _downloadFile(
    BuildContext context,
    Attachment attachment,
  ) async {
    try {
      // Request permission
      bool hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        _showSnackBar(context, 'Storage permission required to download files');
        return;
      }

      // Show downloading message
      _showSnackBar(context, 'Downloading file...');

      // Get download path
      String? downloadPath = await _getDownloadPath();
      if (downloadPath == null) {
        throw Exception('Could not access download directory');
      }

      // Decode base64 and save file
      final bytes = base64Decode(attachment.base64 ?? '');
      final fileName = attachment.name ?? 'downloaded_file';
      final filePath = '$downloadPath/$fileName';

      final file = File(filePath);
      await file.writeAsBytes(bytes);

      // Show success message only if context is still mounted
      if (!context.mounted) return;

      _showSnackBar(
        context,
        'File downloaded: $fileName',
        action: SnackBarAction(
          label: 'Open',
          onPressed: () {
            if (_isPdf(attachment) && context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFViewerScreen(attachment: attachment),
                ),
              );
            }
          },
        ),
      );
    } catch (e) {
      // Check if context is still mounted before showing error
      if (context.mounted) {
        _showSnackBar(context, 'Download failed: ${e.toString()}');
      }
    }
  }

  Future<void> _openFile(BuildContext context, Attachment attachment) async {
    // Check if context is mounted before showing dialog
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(attachment.name ?? 'File Options'),
          content: const Text('What would you like to do with this file?'),
          actions: [
            if (_isPdf(attachment))
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  if (context.mounted) {
                    _openPdfViewer(context, attachment);
                  }
                },
                child: const Text('View PDF'),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (context.mounted) {
                  _downloadFile(context, attachment);
                }
              },
              child: const Text('Download'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openPdfViewer(
    BuildContext context,
    Attachment attachment,
  ) async {
    _showSnackBar(context, 'Opening PDF...');

    try {
      if (!context.mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerScreen(attachment: attachment),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Failed to open PDF: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesDetailsCubit, ExpensesDetailsState>(
      builder: (context, state) {
        var cubit = context.read<ExpensesDetailsCubit>();
        final attachments = data?.data?.attachments ?? [];
        if (attachments.isEmpty) return const SizedBox();

        return Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 200.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: _buildMainDisplay(cubit, attachments, context),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 60.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: attachments.length,
                itemBuilder: (context, index) {
                  final attachment = attachments[index];
                  return _buildThumbnailItem(cubit, attachment, context, index);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainDisplay(
    ExpensesDetailsCubit cubit,
    List<Attachment> attachments,
    BuildContext context,
  ) {
    final selectedIndex = cubit.selectedAttachmentIndex ?? 0;
    final displayAttachment = attachments[selectedIndex];

    if (_isImage(displayAttachment)) {
      final imageBytes = _decodeBase64(displayAttachment.base64);
      if (imageBytes != null) {
        return GestureDetector(
          onTap: () {
            print('Selected image: ${displayAttachment.name}');
          },
          child: Image.memory(
            imageBytes,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error, size: 40),
          ),
        );
      } else {
        return const Center(child: Icon(Icons.error, size: 40));
      }
    } else {
      return GestureDetector(
        onTap: () => _openFile(context, displayAttachment),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getFileIcon(displayAttachment),
                size: 60,
                color: ColorsManager.mainColor1,
              ),
              SizedBox(height: 8.h),
              Text(
                displayAttachment.name ?? 'Unknown file',
                style: TextStyle(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Tap to open',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorsManager.mainColor1,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildThumbnailItem(
    ExpensesDetailsCubit cubit,
    Attachment attachment,
    BuildContext context,
    int index,
  ) {
    final isSelected = index == (cubit.selectedAttachmentIndex ?? 0);

    return GestureDetector(
      onTap: () {
        cubit.selectAttachment(index);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? ColorsManager.mainColor1 : Colors.transparent,
              width: 2,
            ),
          ),
          child: _isImage(attachment)
              ? _buildImageThumbnail(attachment)
              : _buildFileThumbnail(attachment),
        ),
      ),
    );
  }

  Widget _buildImageThumbnail(Attachment attachment) {
    final imageBytes = _decodeBase64(attachment.base64);
    if (imageBytes != null) {
      return Image.memory(
        imageBytes,
        height: 60.h,
        width: 60.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 60.h,
          width: 60.h,
          color: Colors.grey[200],
          child: const Icon(Icons.error),
        ),
      );
    } else {
      return Container(
        height: 60.h,
        width: 60.h,
        color: Colors.grey[200],
        child: const Icon(Icons.error),
      );
    }
  }

  Widget _buildFileThumbnail(Attachment attachment) {
    return Container(
      height: 60.h,
      width: 60.h,
      color: Colors.grey[200],
      child: Icon(
        _getFileIcon(attachment),
        size: 30,
        color: ColorsManager.mainColor1,
      ),
    );
  }
}

class PDFViewerScreen extends StatefulWidget {
  final Attachment attachment;

  const PDFViewerScreen({super.key, required this.attachment});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? tempFilePath;

  @override
  void initState() {
    super.initState();
    _createTempFile();
  }

  Future<void> _createTempFile() async {
    try {
      final bytes = base64Decode(widget.attachment.base64 ?? '');
      final tempDir = await Directory.systemTemp.createTemp();
      final file = File('${tempDir.path}/${widget.attachment.name}');
      await file.writeAsBytes(bytes);
      if (mounted) {
        setState(() {
          tempFilePath = file.path;
        });
      }
    } catch (e) {
      print('Error creating temp file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.attachment.name ?? 'PDF')),
      body: tempFilePath == null
          ? const Center(child: CircularProgressIndicator())
          : const PDF().fromPath(
              tempFilePath!,
              // errorWidget: (error) {
              //   print('PDF Error: $error');
              //   return Center(
              //     child: Text('Error loading PDF: ${error.toString()}'),
              //   );
              // },
            ),
    );
  }

  @override
  void dispose() {
    if (tempFilePath != null) {
      File(
        tempFilePath!,
      ).delete().catchError((e) => print('Error deleting temp file: $e'));
    }
    super.dispose();
  }
}