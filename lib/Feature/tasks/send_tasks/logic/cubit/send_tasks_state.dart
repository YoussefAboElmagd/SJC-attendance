import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_tasks_state.freezed.dart';

@freezed
class SendTasksState with _$SendTasksState {
  const factory SendTasksState.initial() = _Initial;
  const factory SendTasksState.changeDragDownHintSuccess(String? text) =
      ChangeDragDownHintSuccess;

  // File selection states
  const factory SendTasksState.fileSelectionInProgress() =
      FileSelectionInProgress;
  const factory SendTasksState.fileSelected(File file) = FileSelected;
  const factory SendTasksState.fileSelectionCancelled() =
      FileSelectionCancelled;
  const factory SendTasksState.fileSelectionError(String message) =
      FileSelectionError;
  const factory SendTasksState.fileValidationError(String message) =
      FileValidationError;

  // Upload states
  const factory SendTasksState.uploading() = Uploading;
  const factory SendTasksState.uploadSuccess(File file) = UploadSuccess;
  const factory SendTasksState.uploadError(String message) = UploadError;

  // Multi-file selection support
  const factory SendTasksState.multipleFilesSelected(List<File> files) =
      MultipleFilesSelected;
  const factory SendTasksState.removeFile(List<File> files) =
      RemoveFile;
  const factory SendTasksState.uploadProgress(double progress) = UploadProgress;

  // permissions
  const factory SendTasksState.permissionDenied() = PermissionDenied;
  const factory SendTasksState.permissionPermanentlyDenied() =
      PermissionPermanentlyDenied;
}
