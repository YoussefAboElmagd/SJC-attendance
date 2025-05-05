
import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/registration/login/apis/login_services.dart';
import 'package:madarj/Feature/registration/login/data/model/login_request_body.dart';
import 'package:madarj/Feature/registration/login/data/model/login_response_body.dart';

class LoginRepo {
  final LoginService _loginService;
  LoginRepo(this._loginService);

  Future<ApiResults<LoginResponseBody>> login(
      LoginRequestBody loginRequestBody) async {
    try {
      final response = await _loginService.login(loginRequestBody);
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }

  // Future<ApiResults> refreshToken(Map<String, dynamic> body) async {
  //   try {
  //     final response = await _loginService.refreshFcmToken(
  //       body,
  //     );
  //     return ApiResults.success(response);
  //   } catch (error) {
  //     return ApiResults.failure(ApiErrorHandler.handle(error));
  //   }
  // }


}
