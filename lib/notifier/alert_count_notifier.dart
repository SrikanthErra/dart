import 'package:flutter/material.dart';

class AlertsCountProvider with ChangeNotifier {
  int count = 0;
  CountIncrementer() {
    count++;
    notifyListeners();
  }
}
