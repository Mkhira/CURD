import 'package:curd/data/dto_model/login_model.dart';
import 'package:curd/data/dto_model/register_response.dart';
import 'package:curd/data/repository/repository.dart';

import 'base_use_case.dart';

class LoginUseCase implements BaseCase<LoginModel, AuthResponse?> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<AuthResponse?> execute(LoginModel input) async {
    return await _repository.login(input);
  }
}
