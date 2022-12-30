class viewMedicineModel {
  String? MedicineName;
  String? ExpiryDate;
  String? Symptom;
  int? TabletsCount;

  viewMedicineModel({
    this.MedicineName,
    this.ExpiryDate,
    this.Symptom,
    this.TabletsCount,
  });

  viewMedicineModel.fromJson(Map<String, dynamic> json) {
    MedicineName = json['MedicineName'];
    ExpiryDate = json['ExpiryDate'];
    Symptom = json['Symptom'];
    TabletsCount = json['TabletsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MedicineName'] = this.MedicineName;
    data['ExpiryDate'] = this.ExpiryDate;
    data['Symptom'] = this.Symptom;
    data['TabletsCount'] = this.TabletsCount;
    return data;
  }
}
