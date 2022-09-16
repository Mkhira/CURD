import 'package:curd/data/dto_model/register_response.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.response}) : super(key: key);
  final AuthResponse response;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text('USer ID: ${response.id!}'),
                  Text('User Home : ${response.name!}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
