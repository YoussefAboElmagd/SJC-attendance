import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/create_expense_request.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/request_types_model_response.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/send_exp_categories_model_response.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/repo/send_expenses_repo.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';
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
  TextEditingController? departmentId = TextEditingController();
  TextEditingController? selectRequestId = TextEditingController();
  TextEditingController? amountNumber = TextEditingController();
  TextEditingController? expensesDescription = TextEditingController();
  var formKey = GlobalKey<FormState>();
  ExpenseDetailsResponse? expense;

  changeDragDownHint(
    TextEditingController? controller,
    TextEditingController? controllerId,
    String? text,
    String id,
  ) {
    controller!.text = text.toString();
    controllerId!.text = id.toString();
    selectedItem = text.toString();
    emit(SendExpensesState.changeDragDownHintSuccess(text));
  }

  // connect with back
  Future<void> getAllExpenses(BuildContext context, int? id) async {
    emit(const SendExpensesState.loading());

    try {
      final periodFuture = _expensesRepo.getRequestTypes(context);
      final categoriesFuture = _expensesRepo.getCategories(context);
      Future<ApiResults<ExpenseDetailsResponse>>? expenseDetails;
      if (id != null) {
        expenseDetails = _expensesRepo.getExpenseDetails(context, id);
      }
      var responses;
      if (expenseDetails != null) {
        responses = await Future.wait([
          periodFuture,
          categoriesFuture,
          expenseDetails,
        ]);
      } else {
        responses = await Future.wait([periodFuture, categoriesFuture]);
      }

      final requestTypesResult = responses[0] as ApiResults<RequestTypesModel>;
      final categoriesResult = responses[1] as ApiResults<SendExpCategResponse>;
      var expenseDetailsResult;
      if (id != null) {
        expenseDetailsResult =
            responses[2] as ApiResults<ExpenseDetailsResponse>;
      }
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
      if (id != null) {
        expenseDetailsResult.when(
          success: (_) {},
          failure: (error) => handleError(error, 'categoriesResult'),
        );
      }
      print("errors 22222222 $errors");

      if (errors.isNotEmpty) {
        final uniqueMessages = <String>{};
        for (var error in errors) {
          final msg = error.message ?? S.of(context).Unknown_error;
          uniqueMessages.add(msg);
        }

        final combinedMessage = uniqueMessages.join('\n');

        final combinedError = ApiErrorModel(
          message: combinedMessage,
          status: errors.first.status,
        );
        print("combinedError $combinedError");
        emit(SendExpensesState.error(combinedError));
        return;
      }
      print("errors 11111 $errors");

      late final RequestTypesModel requestTypesModel;
      late final SendExpCategResponse categoriesModel;
      ExpenseDetailsResponse? expenseDetailsResponse;
      requestTypesResult.when(
        success: (data) => requestTypesModel = data,
        failure: (_) {},
      );
      categoriesResult.when(
        success: (data) => categoriesModel = data,
        failure: (_) {},
      );
      if (expenseDetailsResult != null) {
        expenseDetailsResult.when(
          success: (data) => expenseDetailsResponse = data,
          failure: (_) {},
        );
      }

      expense = expenseDetailsResponse;
      if (id != null) {
        emit(
          SendExpensesState.combinedSuccessForUpdate(
            requestType: requestTypesModel,
            categories: categoriesModel,
            expenseDetailsResult: expenseDetailsResponse,
          ),
        );
      } else {
        emit(
          SendExpensesState.combinedSuccess(
            requestType: requestTypesModel,
            categories: categoriesModel,
          ),
        );
      }
    } catch (e) {
      print("eeeeeeee $e");
      emit(
        SendExpensesState.error(
          ApiErrorModel(
            message: S.of(context).An_unexpected_error,
            status: '500',
          ),
        ),
      );
    }
  }

  createExpense(BuildContext context, CreateExpenseRequest request) async {
    emit(const SendExpensesState.createExpensesLoading());
    try {
      final response = await _expensesRepo.createExpense(context, request);

      response.when(
        success: (totalHoursResponse) async {
          emit(SendExpensesState.createExpensesSuccess(totalHoursResponse));
        },
        failure: (apiErrorModel) {
          emit(SendExpensesState.createExpensesError(apiErrorModel));
        },
      );
    } catch (e) {
      print(e.toString());
      emit(
        SendExpensesState.createExpensesError(
          ApiErrorModel(message: e.toString()),
        ),
      );
    }
  }

  Future<void> editExpense(
    BuildContext context,
    int expenseId,
    CreateExpenseRequest request,
  ) async {
    emit(const SendExpensesState.createExpensesLoading());
    try {
      final response = await _expensesRepo.editExpense(
        context,
        expenseId,
        request,
      );
      response.when(
        success: (response) async {
          emit(SendExpensesState.createExpensesSuccess(response));
        },
        failure: (apiErrorModel) {
          emit(SendExpensesState.createExpensesError(apiErrorModel));
        },
      );
    } catch (e) {
      emit(
        SendExpensesState.createExpensesError(
          ApiErrorModel(message: e.toString()),
        ),
      );
    }
  }

  // File handling variables
  List<File> selectedFiles = [];
  File? image; // For single image from camera

  // New permission system for better Android SDK 30+ support
  Future<bool> askManageExternalStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 30) {
        if (await Permission.manageExternalStorage.isDenied) {
          await Permission.manageExternalStorage.request();
        }
        return await Permission.manageExternalStorage.isGranted;
      } else {
        if (await Permission.storage.isDenied) {
          await Permission.storage.request();
        }
        return await Permission.storage.isGranted;
      }
    } else if (Platform.isIOS) {
      if (await Permission.photos.isDenied) {
        await Permission.photos.request();
      }
      return await Permission.photos.isGranted;
    }
    return false;
  }

  // Pick single image from camera/gallery
  Future<void> pickImageFromCamera({required BuildContext context}) async {
    if (await askManageExternalStoragePermission()) {
      try {
        emit(const SendExpensesState.fileSelectionInProgress());
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
        );
        if (result != null && result.files.single.path != null) {
          final selectedFile = File(result.files.single.path!);

          // Validate file
          if (_validateSingleImageFile(selectedFile)) {
            selectedFiles.add(selectedFile);
            image = selectedFile;
            emit(SendExpensesState.multipleFilesSelected(selectedFiles));
          } else {
            emit(
              const SendExpensesState.fileValidationError(
                'Invalid file. Only images (JPG, PNG) under 5MB are allowed',
              ),
            );
          }
        } else {
          emit(const SendExpensesState.fileSelectionCancelled());
        }
      } catch (e) {
        debugPrint('Error picking file: $e');
        emit(SendExpensesState.fileSelectionError(e.toString()));
      }
    } else {
      emit(const SendExpensesState.permissionDenied());
    }
  }

  // Pick multiple files (documents and images)
  Future<void> pickMultipleFiles(BuildContext context) async {
    try {
      if (!await askManageExternalStoragePermission()) {
        emit(const SendExpensesState.permissionDenied());
        return;
      }

      emit(const SendExpensesState.fileSelectionInProgress());
      final result = await FilePicker.platform.pickFiles(
        // type: FileType.any,
        // allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: true,
      );

      _handleMultipleFileResult(result);
    } catch (e) {
      emit(SendExpensesState.fileSelectionError(e.toString()));
    }
  }

  // Validate single image file
  bool _validateSingleImageFile(File file) {
    try {
      final fileExtension = file.path.split('.').last.toLowerCase();
      final allowedImageExtensions = ['jpg', 'jpeg', 'png'];

      if (!allowedImageExtensions.contains(fileExtension)) {
        return false;
      }

      // Check file size (5MB limit)
      const maxSize = 5 * 1024 * 1024; // 5MB
      if (file.lengthSync() > maxSize) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  void _handleMultipleFileResult(FilePickerResult? result) {
    if (result != null && result.files.isNotEmpty) {
      final files =
          result.files
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
        emit(
          const SendExpensesState.fileValidationError(
            'No valid files were selected. Only images (JPG, PNG), PDFs and Word documents under 5MB are allowed',
          ),
        );
        return;
      }

      selectedFiles.addAll(validFiles);
      emit(SendExpensesState.multipleFilesSelected(selectedFiles));
    } catch (e) {
      emit(SendExpensesState.fileValidationError(e.toString()));
    }
  }

  // Form validation
  String? departmentError;
  String? requestTypeError;
  bool validateForm() {
    bool isValid = true;

    // Reset errors
    departmentError = null;
    requestTypeError = null;

    // Validate dropdowns
    if (departmentText?.text.isEmpty ?? true) {
      departmentError = 'Please select a department';
      isValid = false;
    }

    if (selectRequestType?.text.isEmpty ?? true) {
      requestTypeError = 'Please select a request type';
      isValid = false;
    }

    emit(const SendExpensesState.errorChooseDragDrop());
    return isValid;
  }
}
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:madarj/Core/networking/api_error_model.dart';
// import 'package:madarj/Core/networking/api_results.dart';
// import 'package:madarj/Feature/expenses/send_expenses/data/model/create_expense_request.dart';
// import 'package:madarj/Feature/expenses/send_expenses/data/model/request_types_model_response.dart';
// import 'package:madarj/Feature/expenses/send_expenses/data/model/send_exp_categories_model_response.dart';
// import 'package:madarj/Feature/expenses/send_expenses/data/repo/send_expenses_repo.dart';
// import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
// import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';
// import 'package:madarj/generated/l10n.dart';
// import 'package:permission_handler/permission_handler.dart';

// class SendExpensesCubit extends Cubit<SendExpensesState> {
//   SendExpensesCubit(this._expensesRepo)
//     : super(const SendExpensesState.initial());
//   final SendExpensesRepo _expensesRepo;

//   // handle ui
//   String? selectedItem;

//   TextEditingController? departmentText = TextEditingController();
//   TextEditingController? selectRequestType = TextEditingController();
//   TextEditingController? departmentId = TextEditingController();
//   TextEditingController? selectRequestId = TextEditingController();
//   TextEditingController? amountNumber = TextEditingController();
//   TextEditingController? expensesDescription = TextEditingController();
//   var formKey = GlobalKey<FormState>();
//   ExpenseDetailsResponse? expense;
  
//   changeDragDownHint(
//     TextEditingController? controller,
//     TextEditingController? controllerId,
//     String? text,
//     String id,
//   ) {
//     controller!.text = text.toString();
//     controllerId!.text = id.toString();
//     selectedItem = text.toString();
//     emit(SendExpensesState.changeDragDownHintSuccess(text));
//   }

//   // connect with back
//   Future<void> getAllExpenses(BuildContext context, int? id) async {
//     emit(const SendExpensesState.loading());

//     try {
//       final periodFuture = _expensesRepo.getRequestTypes(context);
//       final categoriesFuture = _expensesRepo.getCategories(context);
//       Future<ApiResults<ExpenseDetailsResponse>>? expenseDetails;
//       if (id != null) {
//         expenseDetails = _expensesRepo.getExpenseDetails(context, id);
//       }
//       var responses;
//       if (expenseDetails != null) {
//         responses = await Future.wait([
//           periodFuture,
//           categoriesFuture,
//           expenseDetails,
//         ]);
//       } else {
//         responses = await Future.wait([periodFuture, categoriesFuture]);
//       }

//       final requestTypesResult = responses[0] as ApiResults<RequestTypesModel>;
//       final categoriesResult = responses[1] as ApiResults<SendExpCategResponse>;
//       var expenseDetailsResult;
//       if (id != null) {
//         expenseDetailsResult =
//             responses[2] as ApiResults<ExpenseDetailsResponse>;
//       }
//       // Collect all errors
//       final errors = <ApiErrorModel>[];
//       // Helper function to handle errors
//       void handleError(ApiErrorModel error, String type) {
//         print("$type error: $error");
//         errors.add(error);
//       }

//       requestTypesResult.when(
//         success: (_) {},
//         failure: (error) => handleError(error, 'requestTypesResult'),
//       );
//       categoriesResult.when(
//         success: (_) {},
//         failure: (error) => handleError(error, 'categoriesResult'),
//       );
//       if (id != null) {
//         expenseDetailsResult.when(
//           success: (_) {},
//           failure: (error) => handleError(error, 'categoriesResult'),
//         );
//       }
//       print("errors 22222222 $errors");

//       if (errors.isNotEmpty) {
//         final uniqueMessages = <String>{};
//         for (var error in errors) {
//           final msg = error.message ?? S.of(context).Unknown_error;
//           uniqueMessages.add(msg);
//         }

//         final combinedMessage = uniqueMessages.join('\n');

//         final combinedError = ApiErrorModel(
//           message: combinedMessage,
//           status: errors.first.status,
//         );
//         print("combinedError $combinedError");
//         emit(SendExpensesState.error(combinedError));
//         return;
//       }
//       print("errors 11111 $errors");

//       late final RequestTypesModel requestTypesModel;
//       late final SendExpCategResponse categoriesModel;
//       ExpenseDetailsResponse? expenseDetailsResponse;
//       requestTypesResult.when(
//         success: (data) => requestTypesModel = data,
//         failure: (_) {},
//       );
//       categoriesResult.when(
//         success: (data) => categoriesModel = data,
//         failure: (_) {},
//       );
//       if (expenseDetailsResult != null) {
//         expenseDetailsResult.when(
//           success: (data) => expenseDetailsResponse = data,
//           failure: (_) {},
//         );
//       }

//       expense = expenseDetailsResponse;
//       if (id != null) {
//         emit(
//           SendExpensesState.combinedSuccessForUpdate(
//             requestType: requestTypesModel,
//             categories: categoriesModel,
//             expenseDetailsResult: expenseDetailsResponse,
//           ),
//         );
//       } else {
//         emit(
//           SendExpensesState.combinedSuccess(
//             requestType: requestTypesModel,
//             categories: categoriesModel,
//           ),
//         );
//       }
//     } catch (e) {
//       print("eeeeeeee $e");
//       emit(
//         SendExpensesState.error(
//           ApiErrorModel(
//             message: S.of(context).An_unexpected_error,
//             status: '500',
//           ),
//         ),
//       );
//     }
//   }

//   createExpense(BuildContext context, CreateExpenseRequest request) async {
//     emit(const SendExpensesState.createExpensesLoading());
//     try {
//       final response = await _expensesRepo.createExpense(context, request);

//       response.when(
//         success: (totalHoursResponse) async {
//           emit(SendExpensesState.createExpensesSuccess(totalHoursResponse));
//         },
//         failure: (apiErrorModel) {
//           emit(SendExpensesState.createExpensesError(apiErrorModel));
//         },
//       );
//     } catch (e) {
//       print(e.toString());
//       emit(
//         SendExpensesState.createExpensesError(
//           ApiErrorModel(message: e.toString()),
//         ),
//       );
//     }
//   }

//   Future<void> editExpense(
//     BuildContext context,
//     int expenseId,
//     CreateExpenseRequest request,
//   ) async {
//     emit(const SendExpensesState.createExpensesLoading());
//     try {
//       final response = await _expensesRepo.editExpense(
//         context,
//         expenseId,
//         request,
//       );
//       response.when(
//         success: (response) async {
//           emit(SendExpensesState.createExpensesSuccess(response));
//         },
//         failure: (apiErrorModel) {
//           emit(SendExpensesState.createExpensesError(apiErrorModel));
//         },
//       );
//     } catch (e) {
//       emit(
//         SendExpensesState.createExpensesError(
//           ApiErrorModel(message: e.toString()),
//         ),
//       );
//     }
//   }

//   // File handling variables
//   List<File> selectedFiles = [];
//   File? image; // For single image from camera

//   // New file picker methods replacing the old ones
//   Future<void> pickImageFromCamera({
//     required BuildContext context,
//   }) async {
//     if (await askManageExternalStoragePermission()) {
//       try {
//         FilePickerResult? result = await FilePicker.platform.pickFiles(
//           type: FileType.any,
//           // allowMultiple: false,
//         );
//         if (result != null) {
//           image = File(result.files.single.path ?? '');
//           emit(const SendExpensesState.imagePickedSuccess()); // You might need to add this state
//         } else {
//           emit(const SendExpensesState.userCanceled()); // You might need to add this state
//         }
//       } catch (e) {
//         debugPrint('Error picking file: $e');
//         emit(const SendExpensesState.noNewFilesAdded()); // You might need to add this state
//       }
//     }
//   }

//   Future<bool> askManageExternalStoragePermission() async {
//     if (Platform.isAndroid) {
//       final deviceInfo = DeviceInfoPlugin();
//       final androidInfo = await deviceInfo.androidInfo;
//       if (androidInfo.version.sdkInt >= 30) {
//         if (await Permission.manageExternalStorage.isDenied) {
//           await Permission.manageExternalStorage.request();
//         }
//         return await Permission.manageExternalStorage.isGranted;
//       } else {
//         if (await Permission.storage.isDenied) {
//           await Permission.storage.request();
//         }
//         return await Permission.storage.isGranted;
//       }
//     } else if (Platform.isIOS) {
//       if (await Permission.photos.isDenied) {
//         await Permission.photos.request();
//       }
//       return await Permission.photos.isGranted;
//     }
//     return false;
//   }

//   // Updated multiple file picker using the new permission system
//   Future<void> pickMultipleFiles(BuildContext context) async {
//     try {
//       if (!await askManageExternalStoragePermission()) {
//         emit(const SendExpensesState.permissionDenied());
//         return;
//       }

//       emit(const SendExpensesState.fileSelectionInProgress());
//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.any,
//         allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
//         allowMultiple: true,
//       );

//       _handleMultipleFileResult(result);
//     } catch (e) {
//       emit(SendExpensesState.fileSelectionError(e.toString()));
//     }
//   }

//   void _handleMultipleFileResult(FilePickerResult? result) {
//     if (result != null && result.files.isNotEmpty) {
//       final files = result.files
//           .where((file) => file.path != null)
//           .map((file) => File(file.path!))
//           .toList();

//       _validateAndProcessMultipleFiles(files);
//     } else {
//       emit(const SendExpensesState.fileSelectionCancelled());
//     }
//   }

//   void removeFile(File file) {
//     print("file cubit $file");
//     final newFiles = List<File>.from(selectedFiles)..remove(file);
//     selectedFiles = newFiles;

//     emit(SendExpensesState.removeFile(selectedFiles));
//   }

//   void _validateAndProcessMultipleFiles(List<File> files) {
//     try {
//       final allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'];
//       final validFiles = <File>[];

//       for (final file in files) {
//         final fileExtension = file.path.split('.').last.toLowerCase();

//         if (!allowedExtensions.contains(fileExtension)) {
//           continue;
//         }

//         // Check file size (optional - example: 5MB limit)
//         const maxSize = 5 * 1024 * 1024; // 5MB
//         if (file.lengthSync() <= maxSize) {
//           validFiles.add(file);
//         }
//       }

//       if (validFiles.isEmpty) {
//         emit(
//           const SendExpensesState.fileValidationError(
//             'No valid files were selected. Only images (JPG, PNG), PDFs and Word documents under 5MB are allowed',
//           ),
//         );
//         return;
//       }

//       selectedFiles.addAll(validFiles);
//       emit(SendExpensesState.multipleFilesSelected(selectedFiles));
//     } catch (e) {
//       emit(SendExpensesState.fileValidationError(e.toString()));
//     }
//   } 

//   // Form validation
//   String? departmentError;
//   String? requestTypeError;
//   bool validateForm() {
//     bool isValid = true;

//     // Reset errors
//     departmentError = null;
//     requestTypeError = null;

//     // Validate dropdowns
//     if (departmentText?.text.isEmpty ?? true) {
//       departmentError = 'Please select a department';
//       isValid = false;
//     }

//     if (selectRequestType?.text.isEmpty ?? true) {
//       requestTypeError = 'Please select a request type';
//       isValid = false;
//     }

//     emit(const SendExpensesState.errorChooseDragDrop());
//     return isValid;
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:madarj/Core/networking/api_error_model.dart';
// import 'package:madarj/Core/networking/api_results.dart';
// import 'package:madarj/Feature/expenses/send_expenses/data/model/create_expense_request.dart';
// import 'package:madarj/Feature/expenses/send_expenses/data/model/request_types_model_response.dart';
// import 'package:madarj/Feature/expenses/send_expenses/data/model/send_exp_categories_model_response.dart';
// import 'package:madarj/Feature/expenses/send_expenses/data/repo/send_expenses_repo.dart';
// import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_state.dart';
// import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';
// import 'package:madarj/generated/l10n.dart';
// import 'package:permission_handler/permission_handler.dart';

// class SendExpensesCubit extends Cubit<SendExpensesState> {
//   SendExpensesCubit(this._expensesRepo)
//     : super(const SendExpensesState.initial());
//   final SendExpensesRepo _expensesRepo;

//   // handle ui
//   String? selectedItem;

//   TextEditingController? departmentText = TextEditingController();
//   TextEditingController? selectRequestType = TextEditingController();
//   TextEditingController? departmentId = TextEditingController();
//   TextEditingController? selectRequestId = TextEditingController();
//   TextEditingController? amountNumber = TextEditingController();
//   TextEditingController? expensesDescription = TextEditingController();
//   var formKey = GlobalKey<FormState>();
//   ExpenseDetailsResponse? expense;
//   changeDragDownHint(
//     TextEditingController? controller,
//     TextEditingController? controllerId,
//     String? text,
//     String id,
//   ) {
//     controller!.text = text.toString();
//     controllerId!.text = id.toString();
//     selectedItem = text.toString();
//     emit(SendExpensesState.changeDragDownHintSuccess(text));
//   }

//   // connect with back

//   Future<void> getAllExpenses(BuildContext context, int? id) async {
//     emit(const SendExpensesState.loading());

//     try {
//       final periodFuture = _expensesRepo.getRequestTypes(context);
//       final categoriesFuture = _expensesRepo.getCategories(context);
//       Future<ApiResults<ExpenseDetailsResponse>>? expenseDetails;
//       if (id != null) {
//         expenseDetails = _expensesRepo.getExpenseDetails(context, id);
//       }
//       var responses;
//       if (expenseDetails != null) {
//         responses = await Future.wait([
//           periodFuture,
//           categoriesFuture,
//           expenseDetails,
//         ]);
//       } else {
//         responses = await Future.wait([periodFuture, categoriesFuture]);
//       }

//       final requestTypesResult = responses[0] as ApiResults<RequestTypesModel>;
//       final categoriesResult = responses[1] as ApiResults<SendExpCategResponse>;
//       var expenseDetailsResult;
//       if (id != null) {
//         expenseDetailsResult =
//             responses[2] as ApiResults<ExpenseDetailsResponse>;
//       }
//       // Collect all errors
//       final errors = <ApiErrorModel>[];
//       // Helper function to handle errors
//       void handleError(ApiErrorModel error, String type) {
//         print("$type error: $error");
//         errors.add(error);
//       }

//       requestTypesResult.when(
//         success: (_) {},
//         failure: (error) => handleError(error, 'requestTypesResult'),
//       );
//       categoriesResult.when(
//         success: (_) {},
//         failure: (error) => handleError(error, 'categoriesResult'),
//       );
//       if (id != null) {
//         expenseDetailsResult.when(
//           success: (_) {},
//           failure: (error) => handleError(error, 'categoriesResult'),
//         );
//       }
//       print("errors 22222222 $errors");

//       if (errors.isNotEmpty) {
//         final uniqueMessages = <String>{};
//         for (var error in errors) {
//           final msg = error.message ?? S.of(context).Unknown_error;
//           uniqueMessages.add(msg);
//         }

//         final combinedMessage = uniqueMessages.join('\n');

//         final combinedError = ApiErrorModel(
//           message: combinedMessage,
//           status: errors.first.status,
//         );
//         print("combinedError $combinedError");
//         emit(SendExpensesState.error(combinedError));
//         return;
//       }
//       print("errors 11111 $errors");

//       late final RequestTypesModel requestTypesModel;
//       late final SendExpCategResponse categoriesModel;
//       ExpenseDetailsResponse? expenseDetailsResponse;
//       requestTypesResult.when(
//         success: (data) => requestTypesModel = data,
//         failure: (_) {},
//       );
//       categoriesResult.when(
//         success: (data) => categoriesModel = data,
//         failure: (_) {},
//       );
//       if (expenseDetailsResult != null) {
//         expenseDetailsResult.when(
//           success: (data) => expenseDetailsResponse = data,
//           failure: (_) {},
//         );
//       }
//       // departmentId!.text =
//       //     requestTypesModel.requestTypes!.keys.first.toString();
//       // selectRequestId!.text = categoriesModel.categories!.keys.first;
//       expense = expenseDetailsResponse;
//       if (id != null) {
//         emit(
//           SendExpensesState.combinedSuccessForUpdate(
//             requestType: requestTypesModel,
//             categories: categoriesModel,
//             expenseDetailsResult: expenseDetailsResponse,
//           ),
//         );
//       } else {
//         emit(
//           SendExpensesState.combinedSuccess(
//             requestType: requestTypesModel,
//             categories: categoriesModel,
//           ),
//         );
//       }
//     } catch (e) {
//       print("eeeeeeee $e");
//       emit(
//         SendExpensesState.error(
//           ApiErrorModel(
//             message: S.of(context).An_unexpected_error,
//             status: '500',
//           ),
//         ),
//       );
//     }
//   }

//   // Map<String, dynamic> _buildErrorMap(List<ApiErrorModel> errors) {
//   //   return {
//   //     for (var i = 0; i < errors.length; i++)
//   //       'error_$i': errors[i].message ?? 'Unknown error',
//   //   };
//   // }

//   createExpense(BuildContext context, CreateExpenseRequest request) async {
//     emit(const SendExpensesState.createExpensesLoading());
//     try {
//       final response = await _expensesRepo.createExpense(context, request);

//       response.when(
//         success: (totalHoursResponse) async {
//           emit(SendExpensesState.createExpensesSuccess(totalHoursResponse));
//         },
//         failure: (apiErrorModel) {
//           // print("cubit error");
//           emit(SendExpensesState.createExpensesError(apiErrorModel));
//         },
//       );
//     } catch (e) {
//       print(e.toString());
//       emit(
//         SendExpensesState.createExpensesError(
//           ApiErrorModel(message: e.toString()),
//         ),
//       );
//     }
//   }

//   Future<void> editExpense(
//     BuildContext context,
//     int expenseId,
//     CreateExpenseRequest request,
//     // List?files,
//   ) async {
//     emit(const SendExpensesState.createExpensesLoading());
//     try {
//       final response = await _expensesRepo.editExpense(
//         context,
//         expenseId,
//         request,
//       );
//       response.when(
//         success: (response) async {
//           emit(SendExpensesState.createExpensesSuccess(response));
//         },
//         failure: (apiErrorModel) {
//           emit(SendExpensesState.createExpensesError(apiErrorModel));
//         },
//       );
//     } catch (e) {
//       emit(
//         SendExpensesState.createExpensesError(
//           ApiErrorModel(message: e.toString()),
//         ),
//       );
//     }
//   }

//   List<File> selectedFiles = [];

//   Future<void> pickMultipleFiles(BuildContext context) async {
//     try {
//       if (!await _checkAndRequestPermission(FileType.any)) {
//         emit(const SendExpensesState.permissionDenied());
//         return;
//       }

//       emit(const SendExpensesState.fileSelectionInProgress());
//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
//         allowMultiple: true,
//       );

//       _handleMultipleFileResult(result);
//     } catch (e) {
//       emit(SendExpensesState.fileSelectionError(e.toString()));
//     }
//   }

//   Future<bool> _checkAndRequestPermission(FileType fileType) async {
//     if (Platform.isAndroid) {
//       final status = await Permission.storage.request();
//       return status.isGranted;
//     } else if (Platform.isIOS) {
//       if (fileType == FileType.image) {
//         final status = await Permission.photos.request();
//         return status.isGranted;
//       } else {
//         final status = await Permission.storage.request();
//         return status.isGranted;
//       }
//     }
//     return false;
//   }

//   void _handleMultipleFileResult(FilePickerResult? result) {
//     if (result != null && result.files.isNotEmpty) {
//       final files = result.files
//           .where((file) => file.path != null)
//           .map((file) => File(file.path!))
//           .toList();

//       _validateAndProcessMultipleFiles(files);
//     } else {
//       emit(const SendExpensesState.fileSelectionCancelled());
//     }
//   }

//   void removeFile(File file) {
//     print("file cubit $file");
//     final newFiles = List<File>.from(selectedFiles)..remove(file);
//     selectedFiles = newFiles;

//     emit(SendExpensesState.removeFile(selectedFiles));
//   }

//   void _validateAndProcessMultipleFiles(List<File> files) {
//     try {
//       final allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'];
//       final validFiles = <File>[];

//       for (final file in files) {
//         final fileExtension = file.path.split('.').last.toLowerCase();

//         if (!allowedExtensions.contains(fileExtension)) {
//           continue;
//         }

//         // Check file size (optional - example: 5MB limit)
//         const maxSize = 5 * 1024 * 1024; // 5MB
//         if (file.lengthSync() <= maxSize) {
//           validFiles.add(file);
//         }
//       }

//       if (validFiles.isEmpty) {
//         emit(
//           const SendExpensesState.fileValidationError(
//             'No valid files were selected. Only images (JPG, PNG), PDFs and Word documents under 5MB are allowed',
//           ),
//         );
//         return;
//       }

//       selectedFiles.addAll(validFiles);
//       emit(SendExpensesState.multipleFilesSelected(selectedFiles));
//     } catch (e) {
//       emit(SendExpensesState.fileValidationError(e.toString()));
//     }
//   } 
//   // Add this validation method

//   String? departmentError;
//   String? requestTypeError;
//   bool validateForm() {
//     bool isValid = true;

//     // Reset errors
//     departmentError = null;
//     requestTypeError = null;

//     // Validate dropdowns
//     // departmentId!.text
//     if (departmentText?.text.isEmpty ?? true) {
//       departmentError = 'Please select a department';
//       isValid = false;
//     }

//     if (selectRequestType?.text.isEmpty ?? true) {
//       requestTypeError = 'Please select a request type';
//       isValid = false;
//     }

//     // Validate other fields if needed
//     // ...

//     emit(const SendExpensesState.errorChooseDragDrop());
//     return isValid;
//   }
// }
