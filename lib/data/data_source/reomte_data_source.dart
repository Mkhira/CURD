import 'package:curd/data/app_api.dart';
import 'package:curd/data/dto_model/login_model.dart';
import 'package:curd/data/dto_model/register_model.dart';
import 'package:curd/data/dto_model/register_response.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> register(RegisterModel registerModel);
  Future<AuthResponse> login(LoginModel loginModel);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  RemoteDataSourceImplementer.name(this._appServiceClient);
  @override
  Future<AuthResponse> register(RegisterModel registerModel) {
    return _appServiceClient.register(registerModel);
  }

  @override
  Future<AuthResponse> login(LoginModel loginModel) {
    return _appServiceClient.login(loginModel);
  }
}
