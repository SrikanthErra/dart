import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:side_menu/Constants/StringConstants.dart';
import 'dart:io';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:universal_io/io.dart';

class AppShowAlert extends StatelessWidget {
  const AppShowAlert({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return new Center(child: (() {
      print('OS: ${Platform.operatingSystem}');
      if (defaultTargetPlatform == TargetPlatform.android) {
        return new AlertDialog(title: Text(message), actions: [
          TextButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              child: AppInputText(
                  text: strings.Presc_Ok,
                  colors: Colors.blue,
                  size: 20,
                  weight: FontWeight.bold))
        ]);
      } else {
        return new CupertinoAlertDialog(title: Text(message), actions: [
          TextButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              child: AppInputText(
                  text: strings.Presc_Ok,
                  colors: Colors.blue,
                  size: 20,
                  weight: FontWeight.bold))
        ]);
      }
      ;
    })());
  }
}
