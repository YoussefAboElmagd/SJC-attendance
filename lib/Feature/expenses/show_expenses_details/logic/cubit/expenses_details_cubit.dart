import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/repo/get_expense_details_repo.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/logic/cubit/expenses_details_state.dart';

class ExpensesDetailsCubit extends Cubit<ExpensesDetailsState> {
  ExpensesDetailsCubit(this._getExpenseDetailsRepo)
    : super(const ExpensesDetailsState.initial());
  final GetExpenseDetailsRepo _getExpenseDetailsRepo;
  final List<String> imagePaths = [
    'assets/images/avatar.png',
    'assets/images/avatar1.png',
    'assets/images/card-pos.png',
    'assets/images/clock_with_wings.png',
    'assets/images/logout.png',
    'assets/images/sjc_logo.png',
    'assets/images/test_person.jpg',
    'assets/images/task.jpg',
    'assets/images/visa.png',
  ];
  String? imageSelected;
  int? selectedAttachmentIndex;

  void selectImage(String imagePath) {
    imageSelected = imagePath;
    emit(ExpensesDetailsState.changeImage(imagePath));
  }

  // Instead of selectImage(String url)
  void selectAttachment(int index) {
    selectedAttachmentIndex = index;
    emit(ExpensesDetailsState.changeImage(selectedAttachmentIndex));
  }

  getExpenseDetails(BuildContext context, int id) async {
    emit(const ExpensesDetailsState.getExpenseDetaailsloading());
    try {
      final response = await _getExpenseDetailsRepo.getExpenseDetails(
        context,
        id,
      );
      response.when(
        success: (data) {
          emit(ExpensesDetailsState.getExpenseDetaailssuccess(data));
        },
        failure: (error) {
          // print(error);
          emit(ExpensesDetailsState.getExpenseDetaailserror(error));
        },
      );
    } catch (e) {
      emit(
        ExpensesDetailsState.getExpenseDetaailserror(
          ApiErrorModel(
            code: 400,
            message: e.toString(),
            status: "local error",
          ),
        ),
      );
    }
  }
}
