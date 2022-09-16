import 'package:curd/data/data_source/reomte_data_source.dart';
import 'package:curd/data/dto_model/login_model.dart';
import 'package:curd/data/dto_model/register_model.dart';
import 'package:curd/data/dto_model/register_response.dart';

abstract class Repository {
  Future<AuthResponse?> register(RegisterModel registerModel);
  Future<AuthResponse?> login(LoginModel loginModel);
}

class RepositoryImpl extends Repository {
  late RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._remoteDataSource);

  @override
  Future<AuthResponse?> register(RegisterModel registerModel) async {
    try {
      final response = await _remoteDataSource.register(registerModel);
      if (response.id != null) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AuthResponse?> login(LoginModel loginModel) async {
    try {
      final response = await _remoteDataSource.login(loginModel);
      if (response.id != null) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
