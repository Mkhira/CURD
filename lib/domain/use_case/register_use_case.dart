import 'package:curd/data/dto_model/register_model.dart';
import 'package:curd/data/dto_model/register_response.dart';
import 'package:curd/data/repository/repository.dart';
import 'package:curd/domain/use_case/base_use_case.dart';

class RegisterUseCase implements BaseCase<RegisterModel, AuthResponse?> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<AuthResponse?> execute(RegisterModel input) async {
    return await _repository.register(input);
  }
}
