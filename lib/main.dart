import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LogIn.dart';
import 'LogInScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LogIn Page',
      home: LogInScreen(),
      //home: LogIn(),
    );
  }
}
