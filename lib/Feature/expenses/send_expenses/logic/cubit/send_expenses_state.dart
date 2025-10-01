import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';

part 'send_expenses_state.freezed.dart';

@freezed
class SendExpensesState<T> with _$SendExpensesState<T> {
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
  const factory SendExpensesState.removeFile(List<File> files) = RemoveFile;

  // permissions
  const factory SendExpensesState.permissionDenied() = PermissionDenied;
  const factory SendExpensesState.imagePickedSuccess() = ImagePickedSuccess;
  const factory SendExpensesState.userCanceled() = UserCanceled;
  const factory SendExpensesState.noNewFilesAdded() = NoNewFilesAdded;
  const factory SendExpensesState.permissionPermanentlyDenied() =
      PermissionPermanentlyDenied;

  // get request type
  const factory SendExpensesState.loading() = Loading;

  const factory SendExpensesState.error(ApiErrorModel error) = Error;

  const factory SendExpensesState.combinedSuccess({
    required T requestType,
    required T categories,
  }) = CombinedSuccess<T>;

  const factory SendExpensesState.combinedSuccessForUpdate({
    required T requestType,
    required T categories,
    required T expenseDetailsResult,
  }) = CombinedSuccessForUpdate<T>;
  // create expenses
  const factory SendExpensesState.createExpensesLoading() =
      CreateExpensesLoading;
  const factory SendExpensesState.createExpensesSuccess(T response) =
      CreateExpensesSuccess<T>;
  const factory SendExpensesState.createExpensesError(ApiErrorModel error) =
      CreateExpensesError;

  const factory SendExpensesState.errorChooseDragDrop() = ErrorChooseDragDrop;
}
