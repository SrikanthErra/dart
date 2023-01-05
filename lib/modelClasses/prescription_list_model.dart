class prescriptionListModel {
  String? doctorName;
  String? prescriptionDate;
  String? medicineName;
  String? symptoms;

  prescriptionListModel(
      {this.doctorName,
      this.prescriptionDate,
      this.medicineName,
      this.symptoms});

  prescriptionListModel.fromJson(Map<String, dynamic> json) {
    doctorName = json['Doctor Name'];
    prescriptionDate = json['Prescription Date'];
    medicineName = json['Medicine Name'];
    symptoms = json['Symptoms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Doctor Name'] = this.doctorName;
    data['Prescription Date'] = this.prescriptionDate;
    data['Medicine Name'] = this.medicineName;
    data['Symptoms'] = this.symptoms;
    return data;
  }
}