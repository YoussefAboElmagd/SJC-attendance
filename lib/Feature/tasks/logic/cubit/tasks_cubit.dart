import 'package:bloc/bloc.dart';
import 'package:madarj/Feature/tasks/logic/cubit/tasks_state.dart';


class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksState.initial());
}
