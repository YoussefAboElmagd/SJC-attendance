import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState<T> with _$LoginState<T> {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.changeObsecuredState({required bool isObsecur}) =
      ChangeObsecuredState;
  const factory LoginState.loginLoading() = LoginLoading;
  const factory LoginState.loginSuccess(T data) = LoginSuccess<T>;
  const factory LoginState.loginError(ApiErrorModel apiErrorModel) = LoginError;
  const factory LoginState.getMeLoading() = GetMeLoading;
  const factory LoginState.getMeSuccess(T data) = GetMeSuccess<T>;
  const factory LoginState.getMeError(ApiErrorModel apiErrorModel) = GetMeError;
}


// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:ka3ba/Core/networking/api_error_model.dart';

// part 'login_state.freezed.dart';

// @freezed
// class LoginState<T> with _$LoginState<T> {
//   const factory LoginState.initial() = _Initial;
//   const factory LoginState.changeObsecuredState({required bool isObsecur}) =
//       ChangeObsecuredState;
//   const factory LoginState.loading() = Loading;
//   const factory LoginState.success(T data) = Success<T>;
//   const factory LoginState.error(ApiErrorModel apiErrorModel) =  Error;

// }
// part of 'login_cubit.dart';

// @freezed
// class LoginState<T> with _$LoginState<T> {
//   const factory LoginState.initial() = _Initial;
//     const factory LoginState.changeObsecuredState({required bool isObsecur}) =
//       ChangeObsecuredState;
//   const factory LoginState.loginLoading() =  LoginLoading;
//   const factory LoginState.loginSuccess(T data) = LoginSuccess<T>;
//   const factory LoginState.loginError(ApiErrorModel apiErrorModel) =  LoginError;

// }
