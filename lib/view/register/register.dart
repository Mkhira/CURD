import 'package:curd/injector.dart';
import 'package:curd/view/home_screen/home_screen.dart';
import 'package:curd/view/register/register_cuibt_cubit.dart';
import 'package:curd/view/shared/custom_text_fiedl.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  MyRegisterState createState() => MyRegisterState();
}

class MyRegisterState extends State<MyRegister> {
  late RegisterCubit registerCubit;

  @override
  void initState() {
    // TODO: implement initState
    registerCubit = injector.get<RegisterCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 50),
            child: const Text(
              "Create\nAccount",
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(right: 35, left: 35, top: MediaQuery.of(context).size.height * 0.25),
              child: Form(
                key: registerCubit.formKey,
                child: Column(children: [
                  CustomTextFromField(
                      controller: registerCubit.firstName,
                      keyboardType: TextInputType.text,
                      hintText: 'First Name',
                      validation: ValidationBuilder().minLength(2).build()),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFromField(
                    controller: registerCubit.lastName,
                    keyboardType: TextInputType.text,
                    hintText: 'Last Name',
                    validation: ValidationBuilder().minLength(2).build(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFromField(
                    controller: registerCubit.emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'E-mail',
                    validation: ValidationBuilder().email().build(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFromField(
                    controller: registerCubit.password,
                    keyboardType: TextInputType.text,
                    hintText: 'Password',
                    validation: ValidationBuilder().minLength(6).required('Password is required').build(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          await injector.get<RegisterCubit>().register(context).then((response) {
                            if (response != null) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return HomeScreen(
                                  response: response,
                                );
                              }));
                            }
                          });
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 15,
                  ),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
