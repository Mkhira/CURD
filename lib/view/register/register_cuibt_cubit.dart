import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:curd/data/dto_model/register_model.dart';
import 'package:curd/data/dto_model/register_response.dart';
import 'package:curd/domain/use_case/register_use_case.dart';
import 'package:curd/view/shared/loader/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'register_cuibt_state.dart';

class RegisterCubit extends Cubit<RegisterCuibtState> {
  final RegisterUseCase _registerUseCase;
  RegisterCubit(this._registerUseCase) : super(RegisterCuibtInitial());
  String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<AuthResponse?> register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      Loader.showLoader(context);

      await _registerUseCase
          .execute(RegisterModel(
              name: Name(firstName: firstName.text, lastName: lastName.text),
              confirmPassword: password.text,
              email: emailController.text,
              password: password.text,
              role: UserType.user))
          .whenComplete(() => Loader.hideLoader(context));

      return AuthResponse(id: getRandomString(emailController.text.length), name: (emailController.text));
    } else {
      return null;
    }
  }
}
