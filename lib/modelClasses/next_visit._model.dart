class nextVisitModel {
  String? hospitalName;
  String? nextVisitDate;
  String? reason;

  nextVisitModel({this.hospitalName, this.nextVisitDate, this.reason});

  nextVisitModel.fromJson(Map<String, dynamic> json) {
    hospitalName = json['Hospital Name'];
    nextVisitDate = json['Next Visit date'];
    reason = json['Reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Hospital Name'] = this.hospitalName;
    data['Next Visit date'] = this.nextVisitDate;
    data['Reason'] = this.reason;
    return data;
  }
}