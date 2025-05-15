import 'package:bloc/bloc.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/logic/cubit/expenses_details_state.dart';

class ExpensesDetailsCubit extends Cubit<ExpensesDetailsState> {
  ExpensesDetailsCubit() : super(const ExpensesDetailsState.initial());
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

  void selectImage(String imagePath) {
    imageSelected = imagePath;
    emit(ExpensesDetailsState.changeImage(imagePath));
  }
}
