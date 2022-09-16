import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:curd/data/dto_model/login_model.dart';
import 'package:curd/data/dto_model/register_response.dart';
import 'package:curd/domain/use_case/login_use_case.dart';
import 'package:curd/view/shared/loader/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(LoginInitial());

  String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<AuthResponse?> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      Loader.showLoader(context);

      await _loginUseCase
          .execute(LoginModel(
            email: emailController.text,
            password: password.text,
          ))
          .whenComplete(() => Loader.hideLoader(context));

      return AuthResponse(id: getRandomString(emailController.text.length), name: emailController.text);
    } else {
      return null;
    }
  }
}
