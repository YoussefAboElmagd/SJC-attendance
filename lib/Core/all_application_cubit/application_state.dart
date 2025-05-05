part of 'application_cubit.dart';

@freezed
class ApplicationState with _$ApplicationState {
  const factory ApplicationState.initial() = _Initial;
  const factory ApplicationState.changeTheLanguageOfApp(
      {required String language}) = ChangeTheLanguageOfApp;
  const factory ApplicationState.sendingUpdate() = _SendingUpdate;
  const factory ApplicationState.updateSent() = _UpdateSent;
  const factory ApplicationState.stopped() = _Stopped;
  const factory ApplicationState.error(String message) = _Error;
  const factory ApplicationState.changeBottomNav(int?index) = ChangeBottomNav;
}

// abstract class ApplicationState {}

// class initial extends ApplicationState {}

// class RegisterLoadingState extends ApplicationState {}

// class RegisterSuccessState extends ApplicationState {
//   final String? uid;
//   RegisterSuccessState(this.uid);
// }
