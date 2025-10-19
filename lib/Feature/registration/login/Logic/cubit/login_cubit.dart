import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:madarj/Core/helpers/cache_helper.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Feature/home/logic/push_firebase_notification.dart';
import 'package:madarj/Feature/registration/login/data/model/login_request_body.dart';
import 'package:madarj/Feature/registration/login/data/model/login_response_body.dart';
import 'package:madarj/Feature/registration/login/data/repos/login_repo.dart';

import '../../../../../Core/helpers/constants.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  final LoginRepo _loginRepo;
  bool isObsecure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  changeObsecure() {
    isObsecure = !isObsecure;
    emit(LoginState.changeObsecuredState(isObsecur: !isObsecure));
  }

  emitLogin(BuildContext context, LoginRequestBody loginRequestBody) async {
    emit(const LoginState.loginLoading());
    final response = await _loginRepo.login(context, loginRequestBody);

    response.when(
      success: (loginResonse) async {
        print(loginResonse.accessToken);
        await saveUserToken(loginResonse.accessToken, loginResonse.access);

        final remember = await CacheHelper.getData(key: SharedKeys.isLogged);
        await CacheHelper.saveData(
          key: SharedKeys.userEmail,
          value: loginRequestBody.email,
        );
        if (remember == true) {
          await CacheHelper.saveData(key: SharedKeys.isLogged, value: true);
        }

        // print(loginRequestBody.email.split("@")[0]);
        String sanitizedEmail =
            loginRequestBody.email
                .split("@")[0]
                .replaceAll('.', '_')
                .toLowerCase();
        PushNotificationsService.messaging
            .subscribeToTopic('user_$sanitizedEmail')
            .then((val) {
              log('user_${loginRequestBody.email.split("@")[0]}');
            });
        PushNotificationsService.messaging.subscribeToTopic('shift').then((
          val,
        ) {
          log('Subscribed to shift topic');
        });
        emit(LoginState.loginSuccess(loginResonse));
      },
      failure: (apiErrorModel) {
        print("Login failed: ${apiErrorModel.message}");
        emit(LoginState.loginError(apiErrorModel));
      },
    );
  }

  Future<void> saveUserToken(String token, Access access) async {
    await CacheHelper.setSecuredString(key: SharedKeys.userToken, value: token);
    await CacheHelper.saveData(
      key: SharedKeys.isAttendance,
      value: access.attendance,
    );
    await CacheHelper.saveData(
      key: SharedKeys.isExpenses,
      value: access.expenses,
    );
    await CacheHelper.saveData(
      key: SharedKeys.isTimeOff,
      value: access.timeoff,
    );
    await CacheHelper.saveData(
      key: SharedKeys.isPayroll,
      value: access.payroll,
    );
    await CacheHelper.saveData(
      key: SharedKeys.skipBiometric,
      value: access.skipBiometric,
    );

    AppConstants.isLogged = true;
    DioFactory.setTokenAfterLogin(token);
  }
}
