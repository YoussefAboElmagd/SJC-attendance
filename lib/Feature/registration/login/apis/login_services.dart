import 'package:dio/dio.dart';
import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/registration/login/apis/login_constants.dart';
import 'package:madarj/Feature/registration/login/data/model/login_request_body.dart';
import 'package:madarj/Feature/registration/login/data/model/login_response_body.dart';
import 'package:retrofit/retrofit.dart';

part 'login_services.g.dart';

@RestApi(baseUrl: ApiConstants.prodBaseDomain)
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  @POST(LoginConstants.login)
  Future<LoginResponseBody> login(@Body() LoginRequestBody loginRequestBody);

  // @PUT(LoginConstants.fcmToken)
  // Future refreshFcmToken(@Body() Map<String, dynamic> body);
}
