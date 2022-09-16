import 'package:curd/view/login/login.dart';
import 'package:curd/view/login/login_cubit.dart';
import 'package:curd/view/register/register.dart';
import 'package:curd/view/register/register_cuibt_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injector.dart';

void main() async {
  await setUpInjector();
  runApp(MultiBlocProvider(providers: [
    BlocProvider.value(value: injector.get<RegisterCubit>()),
    BlocProvider.value(value: injector.get<LoginCubit>()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, initialRoute: 'login', routes: {
      'login': (context) => const MyLogin(),
      'register': (context) => const MyRegister(),
    });
  }
}
