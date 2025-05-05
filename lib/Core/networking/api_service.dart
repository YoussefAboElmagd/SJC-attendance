import 'package:dio/dio.dart';
import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/registration/login/data/model/login_request_body.dart';
import 'package:madarj/Feature/registration/login/data/model/login_response_body.dart';
// import 'package:labaiik_mo3tmer/Core/networking/api_constants.dart';
// import 'package:labaiik_mo3tmer/Features/registration/login/data/model/login_request_body.dart';
// import 'package:labaiik_mo3tmer/Features/registration/login/data/model/login_response_body.dart';
import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponseBody> login(@Body() LoginRequestBody loginRequestBody);

  // @POST(ApiConstants.login)
  // Future<LoginResponseBody> login(@Body() LoginRequestBody loginRequestBody);

  // @POST(ApiConstants.register)
  // Future<SignUpResponseBody> signUp(@Body() SignUpRequestBody signUpRequestBody);
}
