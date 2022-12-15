class viewMedicineModel {
  String? MedicineName;
  String? ExpiryDate;
  String? Symptom;

  viewMedicineModel({
    this.MedicineName,
    this.ExpiryDate,
    this.Symptom,
  });

  viewMedicineModel.fromJson(Map<String, dynamic> json) {
    MedicineName = json['MedicineName'];
    ExpiryDate = json['ExpiryDate'];
    Symptom = json['Symptom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MedicineName'] = this.MedicineName;
    data['ExpiryDate'] = this.ExpiryDate;
    data['Symptom'] = this.Symptom;
    return data;
  }
}