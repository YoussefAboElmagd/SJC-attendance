import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:madarj/Feature/tasks/send_tasks/data/repo/send_task_repo.dart';
import 'package:madarj/Feature/tasks/send_tasks/logic/cubit/send_tasks_state.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

class SendTasksCubit extends Cubit<SendTasksState> {
  SendTasksCubit(this._sendLeaveRepo) : super(const SendTasksState.initial());
  final SendTaskRepo _sendLeaveRepo;

  String? selectedItem;

  TextEditingController? taskTitle = TextEditingController();
  TextEditingController? taskDescription = TextEditingController();
  TextEditingController? assignTo = TextEditingController();
  TextEditingController? priorityControl = TextEditingController();
  TextEditingController? tagsControl = TextEditingController();

  changeDragDownHint(TextEditingController? controller, String? text) {
    controller!.text = text.toString();
    selectedItem = text.toString();
    emit(SendTasksState.changeDragDownHintSuccess(text));
  }

  List<File> selectedFiles = [];

  Future<void> pickMultipleFiles(BuildContext context) async {
    try {
      if (!await _checkAndRequestPermission(FileType.any)) {
        emit(const SendTasksState.permissionDenied());
        return;
      }

      emit(const SendTasksState.fileSelectionInProgress());
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: true,
      );

      _handleMultipleFileResult(result);
    } catch (e) {
      emit(SendTasksState.fileSelectionError(e.toString()));
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
      emit(const SendTasksState.fileSelectionCancelled());
    }
  }

  void removeFile(File file) {
    print("file cubit $file");
    final newFiles = List<File>.from(selectedFiles)..remove(file);
    selectedFiles = newFiles; 

    emit(SendTasksState.removeFile(selectedFiles));
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
        emit(const SendTasksState.fileValidationError(
            'No valid files were selected. Only images (JPG, PNG), PDFs and Word documents under 5MB are allowed'));
        return;
      }

      selectedFiles.addAll(validFiles);
      emit(SendTasksState.multipleFilesSelected(selectedFiles));
    } catch (e) {
      emit(SendTasksState.fileValidationError(e.toString()));
    }
  }
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

  // Future<void> pickImages() async {
  //   try {
  //     if (!await _checkAndRequestPermission(FileType.image)) {
  //       emit(const SendTasksState.permissionDenied());
  //       return;
  //     }

  //     emit(const SendTasksState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       allowMultiple: true,
  //     );

  //     _handleMultipleFileResult(result);
  //   } catch (e) {
  //     emit(SendTasksState.fileSelectionError(e.toString()));
  //   }
  // }

  // Future<void> pickPdfs() async {
  //   try {
  //     if (!await _checkAndRequestPermission(FileType.custom)) {
  //       emit(const SendTasksState.permissionDenied());
  //       return;
  //     }

  //     emit(const SendTasksState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf'],
  //       allowMultiple: true,
  //     );

  //     _handleMultipleFileResult(result);
  //   } catch (e) {
  //     emit(SendTasksState.fileSelectionError(e.toString()));
  //   }
  // }

  // Future<void> pickWordDocuments() async {
  //   try {
  //     if (!await _checkAndRequestPermission(FileType.custom)) {
  //       emit(const SendTasksState.permissionDenied());
  //       return;
  //     }

  //     emit(const SendTasksState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['doc', 'docx'],
  //       allowMultiple: true,
  //     );

  //     _handleMultipleFileResult(result);
  //   } catch (e) {
  //     emit(SendTasksState.fileSelectionError(e.toString()));
  //   }
  // }

  // void _handleMultipleFileResult(FilePickerResult? result) {
  //   if (result != null && result.files.isNotEmpty) {
  //     final files = result.files
  //         .where((file) => file.path != null)
  //         .map((file) => File(file.path!))
  //         .toList();

  //     _validateAndProcessMultipleFiles(files);
  //   } else {
  //     emit(const SendTasksState.fileSelectionCancelled());
  //   }
  // }

  // void _validateAndProcessMultipleFiles(List<File> files) {
  //   try {
  //     final allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'];
  //     final validFiles = <File>[];

  //     for (final file in files) {
  //       final fileExtension = file.path.split('.').last.toLowerCase();

  //       if (!allowedExtensions.contains(fileExtension)) {
  //         continue; // Skip invalid files
  //       }

  //       // Check file size (optional - example: 5MB limit)
  //       const maxSize = 5 * 1024 * 1024; // 5MB
  //       if (file.lengthSync() <= maxSize) {
  //         validFiles.add(file);
  //       }
  //     }

  //     if (validFiles.isEmpty) {
  //       emit(const SendTasksState.fileValidationError(
  //           'No valid files were selected. Only images (JPG, PNG), PDFs and Word documents under 5MB are allowed'));
  //       return;
  //     }

  //     selectedFiles.addAll(validFiles);
  //     emit(SendTasksState.multipleFilesSelected(selectedFiles));
  //   } catch (e) {
  //     emit(SendTasksState.fileValidationError(e.toString()));
  //   }
  // }

  // Future<void> checkAndPickFiles(BuildContext context, SendTasksCubit cubit,
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

  // Future<void> pickImage() async {
  //   try {
  //     if (!await _checkAndRequestPermission(FileType.image)) {
  //       emit(const SendTasksState.permissionDenied());
  //       return;
  //     }

  //     emit(const SendTasksState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       allowMultiple: true,
  //     );

  //     _handleFileResult(result);
  //   } catch (e) {
  //     emit(SendTasksState.fileSelectionError(e.toString()));
  //   }
  // }

  // Future<void> pickPdf() async {
  //   try {
  //     if (!await _checkAndRequestPermission(FileType.custom)) {
  //       emit(const SendTasksState.permissionDenied());
  //       return;
  //     }

  //     emit(const SendTasksState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf'],
  //       allowMultiple: true,
  //     );

  //     _handleFileResult(result);
  //   } catch (e) {
  //     emit(SendTasksState.fileSelectionError(e.toString()));
  //   }
  // }

  // Future<void> pickWordDocument() async {
  //   try {
  //     if (!await _checkAndRequestPermission(FileType.custom)) {
  //       emit(const SendTasksState.permissionDenied());
  //       return;
  //     }

  //     emit(const SendTasksState.fileSelectionInProgress());
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['doc', 'docx'],
  //       allowMultiple: true,
  //     );

  //     _handleFileResult(result);
  //   } catch (e) {
  //     emit(SendTasksState.fileSelectionError(e.toString()));
  //   }
  // }

  // void _handleFileResult(FilePickerResult? result) {
  //   if (result != null && result.files.isNotEmpty) {
  //     final file = File(result.files.single.path!);
  //     _validateAndProcessFile(file);
  //   }
  //   //   if (result != null && result.files.isNotEmpty) {
  //   //   final files = result.files
  //   //       .map((file) => File(file.path!))
  //   //       .take(3) // Limit to 3 files
  //   //       .toList();
  //   //   _validateAndProcessFiles(files);
  //   // }
  //   else {
  //     emit(const SendTasksState.fileSelectionCancelled());
  //   }
  // }

  // --- Common Validation & Processing ---
  // void _validateAndProcessFile(File file) {
  //   try {
  //     final allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'];
  //     final fileExtension = file.path.split('.').last.toLowerCase();

  //     if (!allowedExtensions.contains(fileExtension)) {
  //       emit(const SendTasksState.fileValidationError(
  //           'Only images (JPG, PNG), PDFs and Word documents are allowed'));
  //       return;
  //     }

  //     // Check file size (optional - example: 5MB limit)
  //     const maxSize = 5 * 1024 * 1024; // 5MB
  //     if (file.lengthSync() > maxSize) {
  //       emit(const SendTasksState.fileValidationError(
  //           'File size exceeds 5MB limit'));
  //       return;
  //     }
  //     file = file;
  //     emit(SendTasksState.fileSelected(file));
  //   } catch (e) {
  //     emit(SendTasksState.fileValidationError(e.toString()));
  //   }
  // }

  // Future<void> checkAndPickFile(BuildContext context, SendTasksCubit cubit,
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
}
