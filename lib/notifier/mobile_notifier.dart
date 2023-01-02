import 'package:flutter/material.dart';

class MobileProvider extends ChangeNotifier {
  String _mobile = "";

  String get getMobile => _mobile;

  saveName(String mobile) {
    _mobile = mobile;
    notifyListeners();
  }
}