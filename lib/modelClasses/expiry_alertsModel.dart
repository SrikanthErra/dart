class expiryAlertModel {
  String? medicalName;
  String? expiryDate;

  expiryAlertModel({this.medicalName, this.expiryDate});

  expiryAlertModel.fromJson(Map<String, dynamic> json) {
    medicalName = json['Medical Name'];
    expiryDate = json['Expiry date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Medical Name'] = this.medicalName;
    data['Expiry date'] = this.expiryDate;
    return data;
  }
}