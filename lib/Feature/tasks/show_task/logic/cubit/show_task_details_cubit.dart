import 'package:bloc/bloc.dart';
import 'package:madarj/Feature/tasks/show_task/logic/cubit/show_task_details_state.dart';

class ShowTaskDetailsCubit extends Cubit<ShowTaskDetailsState> {
  ShowTaskDetailsCubit() : super(const ShowTaskDetailsState.initial());
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
    emit(ShowTaskDetailsState.changeImage(imagePath));
  }
}
