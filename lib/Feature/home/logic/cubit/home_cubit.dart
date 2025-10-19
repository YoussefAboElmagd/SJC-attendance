import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:madarj/Core/helpers/cache_helper.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/custom_alert.dart';
import 'package:madarj/Core/widgets/custom_button.dart';
import 'package:madarj/Feature/home/data/model/check_request.dart';
import 'package:madarj/Feature/home/data/model/clock_status_response.dart';
import 'package:madarj/Feature/home/data/model/get_today_work_response.dart';
import 'package:madarj/Feature/home/data/model/notification_request.dart';
import 'package:madarj/Feature/home/data/model/pay_period_response.dart';
import 'package:madarj/Feature/home/data/model/total_hours.dart';
import 'package:madarj/Feature/home/data/repo/home_repo.dart';
import 'package:madarj/Feature/home/logic/cubit/home_state.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:madarj/Feature/home/logic/firebase_servies_local.dart';
// import 'package:madarj/Feature/home/logic/work_manager_service.dart';
import 'package:madarj/generated/l10n.dart';
// import 'package:workmanager/workmanager.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(const HomeState.initial());
  final HomeRepo _homeRepo;
  // final WorkManagerService workManager = WorkManagerService();

  LocalAuthentication? auth;

  bool isSupported = false;
  bool canCheckBiometrics = false;
  bool authenticated = false;

  /// 1. check user auth before checkin and checkout
  Future<List<BiometricType>> getSupportedBiometrics() async {
    auth ??= LocalAuthentication();
    try {
      final availableBiometrics = await auth!.getAvailableBiometrics();
      debugPrint('Supported biometrics: $availableBiometrics');
      return availableBiometrics;
    } catch (e) {
      debugPrint('Error getting biometrics: $e');
      return [];
    }
  }

  Future<void> checkBiometricsAndAuthenticate({
    required BuildContext context,
    required bool isCheckIn,
  }) async {
    emit(const HomeState.authenticating());
    auth ??= LocalAuthentication();

    try {
      // Check what biometrics are available and enrolled
      final availableBiometrics = await auth!.getAvailableBiometrics();
      debugPrint('Available biometrics: $availableBiometrics');

      // More accurate device capability checks
      final canCheckBiometrics = await auth!.canCheckBiometrics;
      final isDeviceSupported = await auth!.isDeviceSupported();

      if (!canCheckBiometrics ||
          !isDeviceSupported ||
          availableBiometrics.isEmpty) {
        emit(
          HomeState.authError(
            ApiErrorModel(message: S.of(context).No_biometric, status: '400'),
          ),
        );
        return;
      }

      // More precise face recognition detection
      final hasFace = availableBiometrics.contains(BiometricType.face);
      final hasFingerprint = availableBiometrics.contains(
        BiometricType.fingerprint,
      );
      final hasStrongAuth = availableBiometrics.contains(BiometricType.strong);

      if (hasFace) {
        final useFace = await showGenericBiometricDialog(
          context,
          isFace: true,
          isFinger: false,
          text: S.of(context).Would_face,
        );
        if (!useFace) {
          emit(const HomeState.authenticationFailed());
          return;
        }
      } else if (hasStrongAuth && !hasFace) {
        final useBiometric = await showGenericBiometricDialog(
          context,
          isFace: true,
          isFinger: true,
        );
        if (!useBiometric) {
          emit(const HomeState.authenticationFailed());
          return;
        }
      } else if (hasFingerprint) {
        // final useFingerprint = await showFingerprintFallbackDialog(context);
        final useFingerprint = await showGenericBiometricDialog(
          context,
          isFace: false,
          isFinger: true,
          text: S.of(context).Would_fingerprint,
        );
        if (!useFingerprint) {
          emit(const HomeState.authenticationFailed());
          return;
        }
      }

      await _performBiometricAuth(isCheckIn, context);
    } catch (e) {
      debugPrint('Authentication error: $e');
      emit(
        HomeState.authError(
          ApiErrorModel(
            message: '${S.of(context).Authentication_failed} ${e.toString()}',
            status: '500',
          ),
        ),
      );
    }
  }

  // New generic biometric dialog for devices with "strong" auth type
  Future<bool> showGenericBiometricDialog(
    BuildContext context, {
    bool? isFace,
    bool? isFinger,
    String? text,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => CustomAlert(
                content: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 15.h,
                  ),
                  child: SizedBox(
                    height: 250.h,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isFace != null && isFace
                                ? SvgPicture.asset(
                                  width: 60.h,
                                  "assets/svgs/face-id.svg",
                                )
                                : Container(),
                            SizedBox(width: 25.w),
                            Text("Or", style: TextStyles.font24CyranBold),
                            SizedBox(width: 25.w),
                            isFinger != null && isFinger
                                ? SvgPicture.asset(
                                  "assets/svgs/finger.svg",
                                  width: 60.h,
                                )
                                : Container(),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          textAlign: TextAlign.center,
                          text ?? S.of(context).Would_face_finger,
                          style: TextStyles.font16BlackSemiBold,
                        ),
                        const Spacer(),
                        CustomButton(
                          onTap: () {
                            Navigator.pop(context, true);
                          },
                          title: S.of(context).Authenticate_button,
                          textStyle: TextStyles.font14WhiteSemiBold,
                          color: ColorsManager.mainColor1,
                        ),
                        SizedBox(height: 15.h),
                        CustomButton(
                          onTap: () async {
                            Navigator.pop(context, false);
                          },
                          title: S.of(context).Cancel,
                          textStyle: TextStyles.font14WhiteSemiBold,
                          color: ColorsManager.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ) ??
        false;
  }

  Future<bool> showFaceAuthDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => AlertDialog(
                title: SvgPicture.asset("assets/svgs/face-id.svg"),
                content: Text(S.of(context).This_device_supports),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(S.of(context).Cancel),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(S.of(context).Use_Face_ID),
                  ),
                ],
              ),
        ) ??
        false;
  }

  Future<bool> showFingerprintFallbackDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => AlertDialog(
                title: SvgPicture.asset("assets/svgs/finger.svg"),
                content: Text(S.of(context).Would_you_like),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(S.of(context).Cancel),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(S.of(context).Use_Fingerprint),
                  ),
                ],
              ),
        ) ??
        false;
  }

  Future<void> _performBiometricAuth(
    bool isCheckIn,
    BuildContext context,
  ) async {
    try {
      final authenticated = await auth!.authenticate(
        localizedReason: 'Authenticate to continue',
        options: const AuthenticationOptions(
          biometricOnly: false, // ⇦ اسمح بالمصادقة بالـ PIN/Pattern
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        emit(HomeState.authenticated(isCheckIn: isCheckIn));
      } else {
        emit(const HomeState.authenticationFailed());
      }
    } on PlatformException catch (e) {
      // Handle platform-specific errors
      emit(
        HomeState.authError(
          ApiErrorModel(
            message: '${S.of(context).Authentication_error} ${e.message}',
            status: '400',
          ),
        ),
      );
    }
  }

  Future<void> initializeAuth() async {
    auth = LocalAuthentication();
  }

  // 2. Updated getAllHome2 with proper typing
  Future<void> getAllHome2(BuildContext context) async {
    emit(const HomeState.loading());

    try {
      final periodFuture = _homeRepo.getthisPayPeriod(context);
      final hoursFuture = _homeRepo.gettotalHours(context);
      final totalWorkingMonth = _homeRepo.getTotalTodayWork(context);
      final todayAttendanceState = _homeRepo.getAttendanceState(context);

      final responses = await Future.wait([
        periodFuture,
        hoursFuture,
        totalWorkingMonth,
        todayAttendanceState,
      ]);

      // Cast responses to their specific types
      final periodResult = responses[0] as ApiResults<PayPeriodResponse>;
      final hoursResult = responses[1] as ApiResults<TotalHours>;
      final totalWorkingResult =
          responses[2] as ApiResults<List<TodayWorkDayEntry>>;
      final todayAttendanceResult =
          responses[3] as ApiResults<ClockStatusResponse>;

      // Collect all errors
      final errors = <ApiErrorModel>[];

      // Helper function to handle errors
      void handleError(ApiErrorModel error, String type) {
        print("$type error: $error");
        errors.add(error);
      }

      periodResult.when(
        success: (_) {},
        failure: (error) => handleError(error, 'periodResult'),
      );

      hoursResult.when(
        success: (_) {},
        failure: (error) => handleError(error, 'hoursResult'),
      );

      totalWorkingResult.when(
        success: (_) {},
        failure: (error) => handleError(error, 'totalWorkingResult'),
      );
      todayAttendanceResult.when(
        success: (_) {},
        failure: (error) => handleError(error, 'todayAttendanceResult'),
      );

      if (errors.isNotEmpty) {
        final uniqueMessages = <String>{};
        for (var error in errors) {
          final msg = error.message ?? S.of(context).Unknown_error;
          uniqueMessages.add(msg);
        }

        final combinedMessage = uniqueMessages.join('\n');

        final combinedError = ApiErrorModel(
          message: combinedMessage,
          status: errors.first.status,
        );

        emit(HomeState.error(combinedError));
        return;
      }

      // Extract successful data with proper types
      late final PayPeriodResponse periodData;
      late final TotalHours hoursData;
      late final List<TodayWorkDayEntry> totalWorksData;
      late final ClockStatusResponse todayAttendanceSuccess;

      periodResult.when(
        success: (data) => periodData = data,
        failure: (_) {}, // Already handled
      );

      hoursResult.when(success: (data) => hoursData = data, failure: (_) {});

      totalWorkingResult.when(
        success: (data) => totalWorksData = data,
        failure: (_) {},
      );
      todayAttendanceResult.when(
        success: (data) => todayAttendanceSuccess = data,
        failure: (_) {},
      );

      emit(
        HomeState.combinedSuccess(
          period: periodData,
          hours: hoursData,
          totalWorks: totalWorksData,
          todayAttendanceResult: todayAttendanceSuccess,
        ),
      );
    } catch (e) {
      // Handle any unexpected errors
      print("Unexpected error in getAllHome2: $e");
      emit(
        HomeState.error(
          ApiErrorModel(
            message: S.of(context).An_unexpected_error,
            status: '500',
          ),
        ),
      );
    }
  }

  // Map<String, dynamic> _buildErrorMap(List<ApiErrorModel> errors) {
  //   return {
  //     for (var i = 0; i < errors.length; i++)
  //       'error_$i': errors[i].message ?? S.of(context).Unknown_error,
  //   };
  // }

  Future<void> checkUser(BuildContext context) async {
    emit(const HomeState.checkUserLoading());
    try {
      final position = await _getCurrentLocation(context);
      final ipAddress = await _getIpAddress();
      final uuid = await getDeviceIdentifier();

      final response = await _homeRepo.checkUser(
        context,
        CheckRequest(
          longitude: position.longitude,
          latitude: position.latitude,
          ipAddress: ipAddress,
          uuid: uuid,
        ),
      );

      response.when(
        success: (totalHoursResponse) async {
          emit(HomeState.checkUserSuccess(totalHoursResponse));
        },
        failure: (apiErrorModel) {
          print("cubit error");
          emit(HomeState.checkUserError(apiErrorModel));
        },
      );
    } catch (e) {
      print(e.toString());
      emit(HomeState.checkUserError(ApiErrorModel(message: e.toString())));
    }
  }

  /// Utility: Get public IP address
  Future<String> _getIpAddress() async {
    try {
      // Try to get public IP first
      final response = await http
          .get(
            Uri.parse('https://api.ipify.org'),
            headers: {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        return response.body;
      }

      final interfaces = await NetworkInterface.list();
      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          if (!addr.isLoopback && addr.type == InternetAddressType.IPv4) {
            return addr.address;
          }
        }
      }

      return 'unknown';
    } catch (e) {
      return 'unknown';
    }
  }

  /// Utility: Get current location
  Future<Position> _getCurrentLocation(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception(S.of(context).Location_permissions_denied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(S.of(context).Location_permissions_denied_please);
    }
    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    // serviceEnabled=await Geolocator.
    //   throw Exception(S.of(context).Location_disabled);
    // }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  String? clockInText;
  changeClockInText(String? clockInText) {
    CacheHelper.saveData(value: clockInText, key: SharedKeys.clockUser);
    this.clockInText = clockInText;
  }

  Future<String?> getDeviceIdentifier() async {
    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        return await _getAndroidDeviceId(deviceInfo);
      } else if (Platform.isIOS) {
        return await _getIOSDeviceId(deviceInfo);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getting device ID: $e');
      return null;
    }
  }

  Future<String?> _getAndroidDeviceId(DeviceInfoPlugin deviceInfo) async {
    try {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } catch (e) {
      debugPrint('Error getting Android device ID: $e');
      return null;
    }
  }

  Future<String?> _getIOSDeviceId(DeviceInfoPlugin deviceInfo) async {
    try {
      final iosInfo = await deviceInfo.iosInfo;
      // On iOS, we use identifierForVendor which persists per app vendor
      return iosInfo.identifierForVendor;
    } catch (e) {
      debugPrint('Error getting iOS device ID: $e');
      return null;
    }
  }

  sendToken(
    BuildContext context,
    NotificationRequest notificationRequest,
  ) async {
    emit(state);
    var resoponse = await _homeRepo.snedToken(context, notificationRequest);
    resoponse.when(
      success: (data) {
        emit(state);
      },
      failure: (ApiErrorModel apiErrorModel) {
        emit(state);
      },
    );
  }

  Future<void> createEditRequest(BuildContext context, int attendanceId) async {
    emit(const HomeState.editRequestLoading());
    var response = await _homeRepo.createEditRequest(context, attendanceId);
    response.when(
      success: (data) {
        emit(HomeState.editRequestSuccess(data));
      },
      failure: (ApiErrorModel apiErrorModel) {
        emit(HomeState.editRequestError(apiErrorModel));
      },
    );
  }
}
