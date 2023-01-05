import 'package:flutter/cupertino.dart';

class gridListView {
  String? title;
  Image? image;
  String? navigateApproute;

  gridListView({this.title, this.image, this.navigateApproute});

  gridListView.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['icon'];
    navigateApproute = json['NavigateApproute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['NavigateApproute'] = this.navigateApproute;
    return data;
  }
}
