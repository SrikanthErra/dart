class registrationFamilyModel {
  String? name;
  String? age;
  String? gender;
  String? mobile;
  String? mpin;
  registrationFamilyModel({this.name, this.age, this.gender, this.mobile,this.mpin});

  registrationFamilyModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    mobile = json['mobileNumber'];
    mpin = json['mpin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['mobileNumber'] = this.mobile;
    data['mpin'] = this.mpin;
    return data;
  }
}
