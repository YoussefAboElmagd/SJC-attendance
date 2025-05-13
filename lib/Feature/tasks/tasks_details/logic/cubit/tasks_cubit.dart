import 'package:bloc/bloc.dart';
import 'package:madarj/Feature/tasks/tasks_details/logic/cubit/tasks_state.dart';


class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(const TasksState.initial());
}
