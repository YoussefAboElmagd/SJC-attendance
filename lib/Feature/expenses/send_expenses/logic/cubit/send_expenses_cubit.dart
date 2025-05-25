import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/create_expense_request.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/request_types_model_response.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/send_exp_categories_model_response.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/repo/send_expenses_repo.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

class SendExpensesCubit extends Cubit<SendExpensesState> {
  SendExpensesCubit(this._expensesRepo)
      : super(const SendExpensesState.initial());
  final SendExpensesRepo _expensesRepo;

  // handle ui
  String? selectedItem;

  TextEditingController? departmentText = TextEditingController();
  TextEditingController? selectRequestType = TextEditingController();
  TextEditingController? amountNumber = TextEditingController();
  TextEditingController? expensesDescription = TextEditingController();
  var formKey = GlobalKey<FormState>();

  changeDragDownHint(TextEditingController? controller, String? text) {
    controller!.text = text.toString();
    selectedItem = text.toString();
    emit(SendExpensesState.changeDragDownHintSuccess(text));
  }

  // connect with back

  Future<void> getAllExpenses(BuildContext context) async {
    emit(const SendExpensesState.loading());

    try {
      final periodFuture = _expensesRepo.getRequestTypes();
      final categoriesFuture = _expensesRepo.getCategories();

      final responses = await Future.wait([
        periodFuture,
        categoriesFuture,
      ]);

      final requestTypesResult = responses[0] as ApiResults<RequestTypesModel>;
      final categoriesResult = responses[1] as ApiResults<SendExpCategResponse>;
      // Collect all errors
      final errors = <ApiErrorModel>[];

      // Helper function to handle errors
      void handleError(ApiErrorModel error, String type) {
        print("$type error: $error");
        errors.add(error);
      }

      requestTypesResult.when(
        success: (_) {},
        failure: (error) => handleError(error, 'requestTypesResult'),
      );
      categoriesResult.when(
        success: (_) {},
        failure: (error) => handleError(error, 'categoriesResult'),
      );

      if (errors.isNotEmpty) {
        final uniqueMessages = <String>{};
        for (var error in errors) {
          final msg = error.message ?? 'Unknown error';
          uniqueMessages.add(msg);
        }

        final combinedMessage = uniqueMessages.join('\n');

        final combinedError = ApiErrorModel(
          message: combinedMessage,
          status: errors.first.status,
        );

        emit(SendExpensesState.error(combinedError));
        return;
      }

      late final RequestTypesModel requestTypesModel;
      late final SendExpCategResponse categoriesModel;

      requestTypesResult.when(
        success: (data) => requestTypesModel = data,
        failure: (_) {},
      );
      categoriesResult.when(
        success: (data) => categoriesModel = data,
        failure: (_) {},
      );

      emit(
        SendExpensesState.combinedSuccess(
          requestType: requestTypesModel,
          categories: categoriesModel,
        ),
      );
    } catch (e) {
      emit(SendExpensesState.error(ApiErrorModel(
        message: S.of(context).An_unexpected_error,
        status: '500',
      )));
    }
  }

  Map<String, dynamic> _buildErrorMap(List<ApiErrorModel> errors) {
    return {
      for (var i = 0; i < errors.length; i++)
        'error_$i': errors[i].message ?? 'Unknown error'
    };
  }

  createExpense(
    CreateExpenseRequest request,
  ) async {
    emit(const SendExpensesState.createExpensesLoading());
    try {
      final response = await _expensesRepo.createExpense(request);

      response.when(
        success: (totalHoursResponse) async {
          emit(SendExpensesState.createExpensesSuccess(totalHoursResponse));
        },
        failure: (apiErrorModel) {
          // print("cubit error");
          emit(SendExpensesState.createExpensesError(apiErrorModel));
        },
      );
    } catch (e) {
      print(e.toString());
      emit(SendExpensesState.createExpensesError(
        ApiErrorModel(
          message: e.toString(),
        ),
      ));
    }
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
}
