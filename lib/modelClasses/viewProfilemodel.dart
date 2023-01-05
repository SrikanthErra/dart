class viewProfileModel {
  String? Mobile;

  viewProfileModel(
      {this.Mobile});

  viewProfileModel.fromJson(Map<String, dynamic> json) {
    Mobile = json['Mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Mobile'] = this.Mobile;
    return data;
  }
}