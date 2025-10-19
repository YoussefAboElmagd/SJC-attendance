import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
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
        // print(loginResonse.accessToken);
        await saveUserToken(loginResonse.accessToken, loginResonse.access);

        final remember = await CachHelper.getData(key: SharedKeys.isLogged);
        await CachHelper.saveData(
          key: SharedKeys.userEmail,
          value: loginRequestBody.email,
        );
        if (remember == true) {
          await CachHelper.saveData(key: SharedKeys.isLogged, value: true);
        }
        saveUserCredentials(
          email: loginRequestBody.email,
          password: loginRequestBody.password,
          rememberMe: true,
        );
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
        // print("Login failed: ${apiErrorModel.message}");
        emit(LoginState.loginError(apiErrorModel));
      },
    );
  }

  Future<void> loadLastUserCredentials() async {
    try {
      final lastUser = await CachHelper.getLastUser();
      if (lastUser != null) {
        emailController.text = lastUser['email']!;
        passwordController.text = lastUser['password']!;

        emit(
          LoginState.credentialsLoaded(
            email: lastUser['email'],
            password: lastUser['password'],
          ),
        );
      }
    } catch (e) {
      // debugPrint('Error loading last user credentials: $e');
    }
  }

  Future<void> saveUserCredentials({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    // if (rememberMe) {
    await CachHelper.saveUserCredentials(email: email, password: password);
    // }
  }

  Future<void> saveUserToken(String token, Access access) async {
    await CachHelper.setSecuredString(key: SharedKeys.userToken, value: token);
    await CachHelper.saveData(
      key: SharedKeys.isAttendance,
      value: access.attendance,
    );
    await CachHelper.saveData(
      key: SharedKeys.isExpenses,
      value: access.expenses,
    );
    await CachHelper.saveData(key: SharedKeys.isTimeOff, value: access.timeoff);
    await CachHelper.saveData(key: SharedKeys.isPayroll, value: access.payroll);
    await CachHelper.saveData(
      key: SharedKeys.skipBiometric,
      value: access.skipBiometric,
    );

    AppConstants.isLogged = true;
    DioFactory.setTokenAfterLogin(token);
  }

  Future<void> loadSavedCredentials() async {
    try {
      emit(const LoginState.loginLoading());

      final rememberMe =
          await CachHelper.getData(key: SharedKeys.rememberMe) as bool? ??
          false;

      if (rememberMe) {
        final credentials = await CachHelper.getSavedLoginCredentials();

        if (credentials['email'] != null) {
          emailController.text = credentials['email']!;

          // Only auto-fill password if credentials exist
          if (credentials['password'] != null) {
            passwordController.text = credentials['password']!;
          }

          emit(
            LoginState.credentialsLoaded(
              email: credentials['email'],
              password: credentials['password'],
            ),
          );
        } else {
          emit(const LoginState.initial());
        }
      } else {
        emit(const LoginState.initial());
      }
    } catch (e) {
      // debugPrint('LoginCubit: Error loading saved credentials: $e');
      emit(const LoginState.initial());
    }
  }

  Future<bool> hasSavedUsers() async {
    try {
      final users = await CachHelper.getSavedUsers();
      return users.isNotEmpty;
    } catch (e) {
      // debugPrint('Error checking saved users: $e');
      return false;
    }
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    formKey.currentState?.reset();
  }
}
