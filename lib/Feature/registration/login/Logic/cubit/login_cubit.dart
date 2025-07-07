import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Feature/registration/login/data/model/login_request_body.dart';
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

  emitLogin(BuildContext context,LoginRequestBody loginRequestBody) async {
    emit(const LoginState.loginLoading());
    final response = await _loginRepo.login(context,loginRequestBody);

    response.when(
      success: (loginResonse) async {
        print(loginResonse.accessToken);
        await saveUserToken(loginResonse.accessToken);
        emit(LoginState.loginSuccess(loginResonse));
      },
      failure: (apiErrorModel) {
        // print("error cubit");
        print("Login failed: ${apiErrorModel.message}");

        emit(
          LoginState.loginError(apiErrorModel),
        );
      },
    );
  }

  Future<void> saveUserToken(String token) async {
    await CachHelper.setSecuredString(
      key: SharedKeys.userToken,
      value: token,
    );
    AppConstants.isLogged = true;
    DioFactory.setTokenAfterLogin(token);
  }
}
