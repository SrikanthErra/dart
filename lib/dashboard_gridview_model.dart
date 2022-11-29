import 'package:flutter/animation.dart';

class gridListView {
  String? title;
  Color? color;
  String? navigateApproute;

  gridListView({this.title, this.color, this.navigateApproute});

  gridListView.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    color = json['color'];
    navigateApproute = json['NavigateApproute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['color'] = this.color;
    data['NavigateApproute'] = this.navigateApproute;
    return data;
  }
}
