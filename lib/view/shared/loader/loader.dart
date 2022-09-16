import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader {
  static Future<void> showLoader(
    BuildContext context,
  ) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(elevation: 0, backgroundColor: Colors.transparent, children: <Widget>[
                Center(
                  child: Lottie.asset(
                    'assets/animation/loader1.json',
                    width: 300,
                  ),
                )
              ]));
        });
  }

  static hideLoader(context) {
    Navigator.pop(context);
  }
}
