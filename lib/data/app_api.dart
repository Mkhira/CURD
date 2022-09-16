import 'package:curd/constant/app_constant.dart';
import 'package:curd/data/dto_model/register_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'dto_model/login_model.dart';
import 'dto_model/register_model.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: AppConstant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("user/signUp")
  Future<AuthResponse> register(@Body() RegisterModel registerModel);
  @POST("user/signIn")
  Future<AuthResponse> login(@Body() LoginModel loginModel);
}
