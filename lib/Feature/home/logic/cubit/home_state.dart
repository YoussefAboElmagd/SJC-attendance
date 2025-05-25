import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
// import 'package:madarj/Feature/home/data/model/pay_period_response.dart';
// import 'package:madarj/Feature/home/data/model/total_hours.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState<T> with _$HomeState<T> {
  const factory HomeState.initial() = _Initial;

  const factory HomeState.getthisPayPeriodLoading() = GetthisPayPeriodLoading;
  const factory HomeState.getthisPayPeriodSuccess(T data) =
      GetthisPayPeriodSuccess<T>;
  const factory HomeState.getthisPayPeriodError(ApiErrorModel error) =
      GetthisPayPeriodError;

  const factory HomeState.gettotalHoursLoading() = GettotalHoursLoading;
  const factory HomeState.gettotalHoursSuccess(T data) =
      GettotalHoursSuccess<T>;
  const factory HomeState.gettotalHoursError(ApiErrorModel error) =
      GettotalHoursError;

  const factory HomeState.loading() = Loading;

  const factory HomeState.error(ApiErrorModel error) = Error;

  const factory HomeState.combinedSuccess({
    required T period,
    required T hours,
    required T totalWorks,
    required T todayAttendanceResult,
  }) = CombinedSuccess<T>;

  //
  const factory HomeState.checkUserLoading() = CheckUserLoading;
  const factory HomeState.checkUserSuccess(T data) = CheckUserSuccess<T>;
  const factory HomeState.checkUserError(ApiErrorModel error) = CheckUserError;

  //
  const factory HomeState.supported() = HomeSupportedState;
  const factory HomeState.biometricsAvailable() = HomeBiometricsAvailable;
  const factory HomeState.authenticating() = HomeAuthenticating;
  const factory HomeState.authenticationFailed() = HomeAuthenticationFailed;
  const factory HomeState.lockedOut() = HomeAuthenticationLockedOut;
  const factory HomeState.authError(ApiErrorModel error) = AuthError;
  const factory HomeState.authenticated({required bool isCheckIn}) =
      HomeAuthenticated;
}
