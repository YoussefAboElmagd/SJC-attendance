import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_expenses_state.freezed.dart';

@freezed
class SendExpensesState with _$SendExpensesState {
  const factory SendExpensesState.initial() = _Initial;

  // change drop down
  const factory SendExpensesState.changeDragDownHintSuccess(String? text) =
      ChangeDragDownHintSuccess;

  // File selection states
  const factory SendExpensesState.fileSelectionInProgress() =
      FileSelectionInProgress;
  const factory SendExpensesState.fileSelected(File file) = FileSelected;
  const factory SendExpensesState.fileSelectionCancelled() =
      FileSelectionCancelled;
  const factory SendExpensesState.fileSelectionError(String message) =
      FileSelectionError;
  const factory SendExpensesState.fileValidationError(String message) =
      FileValidationError;

  // Upload states
  const factory SendExpensesState.uploading() = Uploading;
  const factory SendExpensesState.uploadSuccess(File file) = UploadSuccess;
  const factory SendExpensesState.uploadError(String message) = UploadError;

  // Multi-file selection support
  const factory SendExpensesState.multipleFilesSelected(List<File> files) =
      MultipleFilesSelected;
  const factory SendExpensesState.uploadProgress(double progress) =
      UploadProgress;
  const factory SendExpensesState.removeFile(List<File> files) =
        RemoveFile;
  
  // permissions
  const factory SendExpensesState.permissionDenied() = PermissionDenied;
  const factory SendExpensesState.permissionPermanentlyDenied() =
      PermissionPermanentlyDenied;
}
