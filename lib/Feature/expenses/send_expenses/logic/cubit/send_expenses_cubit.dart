import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/repo/send_expenses_repo.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

class SendExpensesCubit extends Cubit<SendExpensesState> {
  SendExpensesCubit(this._expensesRepo)
      : super(const SendExpensesState.initial());
  final SendExpensesRepo _expensesRepo;

  String? selectedItem;

  TextEditingController? expensesCtegory = TextEditingController();
  TextEditingController? expensesDuration = TextEditingController();
  TextEditingController? amountNumber = TextEditingController();
  TextEditingController? expensesDescription = TextEditingController();

  changeDragDownHint(TextEditingController? controller, String? text) {
    controller!.text = text.toString();
    selectedItem = text.toString();
    emit(SendExpensesState.changeDragDownHintSuccess(text));
  }

    List<File> selectedFiles = [];

  Future<void> pickMultipleFiles(BuildContext context) async {
    try {
      if (!await _checkAndRequestPermission(FileType.any)) {
        emit(const SendExpensesState.permissionDenied());
        return;
      }

      emit(const SendExpensesState.fileSelectionInProgress());
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: true,
      );

      _handleMultipleFileResult(result);
    } catch (e) {
      emit(SendExpensesState.fileSelectionError(e.toString()));
    }
  }

  Future<bool> _checkAndRequestPermission(FileType fileType) async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    } else if (Platform.isIOS) {
      if (fileType == FileType.image) {
        final status = await Permission.photos.request();
        return status.isGranted;
      } else {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    }
    return false;
  }

  void _handleMultipleFileResult(FilePickerResult? result) {
    if (result != null && result.files.isNotEmpty) {
      final files = result.files
          .where((file) => file.path != null)
          .map((file) => File(file.path!))
          .toList();

      _validateAndProcessMultipleFiles(files);
    } else {
      emit(const SendExpensesState.fileSelectionCancelled());
    }
  }

  void removeFile(File file) {
    print("file cubit $file");
    final newFiles = List<File>.from(selectedFiles)..remove(file);
    selectedFiles = newFiles; 

    emit(SendExpensesState.removeFile(selectedFiles));
  }

  void _validateAndProcessMultipleFiles(List<File> files) {
    try {
      final allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'];
      final validFiles = <File>[];

      for (final file in files) {
        final fileExtension = file.path.split('.').last.toLowerCase();

        if (!allowedExtensions.contains(fileExtension)) {
          continue;
        }

        // Check file size (optional - example: 5MB limit)
        const maxSize = 5 * 1024 * 1024; // 5MB
        if (file.lengthSync() <= maxSize) {
          validFiles.add(file);
        }
      }

      if (validFiles.isEmpty) {
        emit(const SendExpensesState.fileValidationError(
            'No valid files were selected. Only images (JPG, PNG), PDFs and Word documents under 5MB are allowed'));
        return;
      }

      selectedFiles.addAll(validFiles);
      emit(SendExpensesState.multipleFilesSelected(selectedFiles));
    } catch (e) {
      emit(SendExpensesState.fileValidationError(e.toString()));
    }
  }

  // File? file;
  // Future<bool> _checkAndRequestPermission(FileType fileType) async {
  //   Permission permission;
  //   if (Platform.isAndroid) {
  //     if (await Permission.storage.request().isGranted) {
  //       return true;
  //     }
  //   } else if (Platform.isIOS) {
  //     switch (fileType) {
  //       case FileType.image:
  //         permission = Permission.photos;
  //         break;
  //       case FileType.custom:
  //       case FileType.any:
  //         permission = Permission.storage;
  //         break;
  //       default:
  //         permission = Permission.storage;
  //     }
  //     if (await permission.request().isGranted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // Future<void> pickImage() async {
  //   try {
  //     if (!await _checkAndRequestPermission(FileType.image)) {
  //       emit(const SendExpensesState.permissionDenied());
  //       return;
  //     }

  //     emit(const SendExpensesState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       allowMultiple: false,
  //     );

  //     _handleFileResult(result);
  //   } catch (e) {
  //     emit(SendExpensesState.fileSelectionError(e.toString()));
  //   }
  // }

  // Future<void> pickPdf() async {
  //   try {
  //     if (!await _checkAndRequestPermission(FileType.custom)) {
  //       emit(const SendExpensesState.permissionDenied());
  //       return;
  //     }

  //     emit(const SendExpensesState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf'],
  //       allowMultiple: false,
  //     );

  //     _handleFileResult(result);
  //   } catch (e) {
  //     emit(SendExpensesState.fileSelectionError(e.toString()));
  //   }
  // }

  // Future<void> pickWordDocument() async {
  //   try {
  //     if (!await _checkAndRequestPermission(FileType.custom)) {
  //       emit(const SendExpensesState.permissionDenied());
  //       return;
  //     }

  //     emit(const SendExpensesState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['doc', 'docx'],
  //       allowMultiple: false,
  //     );

  //     _handleFileResult(result);
  //   } catch (e) {
  //     emit(SendExpensesState.fileSelectionError(e.toString()));
  //   }
  // }

  // void _handleFileResult(FilePickerResult? result) {
  //   if (result != null && result.files.isNotEmpty) {
  //     final file = File(result.files.single.path!);
  //     _validateAndProcessFile(file);
  //   } else {
  //     emit(const SendExpensesState.fileSelectionCancelled());
  //   }
  // }

  // // --- Common Validation & Processing ---
  // void _validateAndProcessFile(File file) {
  //   try {
  //     final allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'];
  //     final fileExtension = file.path.split('.').last.toLowerCase();

  //     if (!allowedExtensions.contains(fileExtension)) {
  //       emit(const SendExpensesState.fileValidationError(
  //           'Only images (JPG, PNG), PDFs and Word documents are allowed'));
  //       return;
  //     }

  //     // Check file size (optional - example: 5MB limit)
  //     const maxSize = 5 * 1024 * 1024; // 5MB
  //     if (file.lengthSync() > maxSize) {
  //       emit(const SendExpensesState.fileValidationError(
  //           'File size exceeds 5MB limit'));
  //       return;
  //     }
  //     file = file;
  //     print("file joe $file");
  //     print("file joe ${file == null}");
  //     emit(SendExpensesState.fileSelected(file));
  //   } catch (e) {
  //     emit(SendExpensesState.fileValidationError(e.toString()));
  //   }
  // }

  // Future<void> checkAndPickFile(BuildContext context, SendExpensesCubit cubit,
  //     FileType fileType, Future<void> Function() pickFunction) async {
  //   final s = S.of(context);
  //   try {
  //     final permissionGranted = await requestPermission(fileType);
  //     if (!permissionGranted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(s.permission_denied)),
  //       );
  //       return;
  //     }

  //     await pickFunction();
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('${s.error_occurred}: $e')),
  //     );
  //   }
  // }

  // Future<bool> requestPermission(FileType fileType) async {
  //   if (Platform.isAndroid) {
  //     final status = await Permission.storage.request();
  //     return status.isGranted;
  //   } else if (Platform.isIOS) {
  //     if (fileType == FileType.image) {
  //       final status = await Permission.photos.request();
  //       return status.isGranted;
  //     } else {
  //       final status = await Permission.storage.request();
  //       return status.isGranted;
  //     }
  //   }
  //   return false;
  // }

  // // --- File Selection Functions ---

  // Future<void> pickImage() async {
  //   try {
  //     emit(const SendExpensesState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       allowMultiple: false,
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       final file = File(result.files.single.path!);
  //       _validateAndProcessFile(file);
  //     } else {
  //       emit(const SendExpensesState.fileSelectionCancelled());
  //     }
  //   } catch (e) {
  //     emit(SendExpensesState.fileSelectionError(e.toString()));
  //   }
  // }

  // Future<void> pickPdf() async {
  //   try {
  //     emit(const SendExpensesState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf'],
  //       allowMultiple: false,
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       final file = File(result.files.single.path!);
  //       _validateAndProcessFile(file);
  //     } else {
  //       emit(const SendExpensesState.fileSelectionCancelled());
  //     }
  //   } catch (e) {
  //     emit(SendExpensesState.fileSelectionError(e.toString()));
  //   }
  // }

  // Future<void> pickWordDocument() async {
  //   try {
  //     emit(const SendExpensesState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['doc', 'docx'],
  //       allowMultiple: false,
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       final file = File(result.files.single.path!);
  //       _validateAndProcessFile(file);
  //     } else {
  //       emit(const SendExpensesState.fileSelectionCancelled());
  //     }
  //   } catch (e) {
  //     emit(SendExpensesState.fileSelectionError(e.toString()));
  //   }
  // }
  // --- File Upload Logic ---
  // Future<void> uploadSelectedFile() async {
  //   final currentState = state;
  //   if (currentState is! FileSelected) return;

  //   try {
  //     emit(const SendExpensesState.uploading());
  //     await _simulateUpload(currentState.file);
  //     emit(SendExpensesState.uploadSuccess(currentState.file));
  //   } catch (e) {
  //     emit(SendExpensesState.uploadError(e.toString()));
  //   }
  // }

  // Future<void> _simulateUpload(File file) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   // Replace with actual upload logic:
  //   // final response = await YourApiService.uploadExpenseFile(file);
  //   // if (!response.success) throw Exception(response.error);
  // }
}
