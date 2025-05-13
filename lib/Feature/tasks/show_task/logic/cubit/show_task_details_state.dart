import 'package:freezed_annotation/freezed_annotation.dart';

part 'show_task_details_state.freezed.dart';

@freezed
class ShowTaskDetailsState<T> with _$ShowTaskDetailsState<T> {
  const factory ShowTaskDetailsState.initial() = _Initial;
  const factory ShowTaskDetailsState.changeImage(T data) = ChangeImage<T>;
}
