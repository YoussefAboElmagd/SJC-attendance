import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasks_state.freezed.dart';

@freezed
class TasksState with _$TasksState {
  const factory TasksState.initial() = _Initial;
}
