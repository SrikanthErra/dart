class MedicineModel {
  int? MedicineId;
  String? MedicineName;
  String? ExpiryDate;
  String? MedicinePhoto;
  int? TabletsCount;
  int? SymptomId;

  MedicineModel({
    this.MedicineId,
    this.MedicineName,
    this.ExpiryDate,
    this.MedicinePhoto,
    this.SymptomId,
    this.TabletsCount,
  });

  MedicineModel.fromJson(Map<String, dynamic> json) {
    MedicineId = json['MedicineId'];
    MedicineName = json['MedicineName'];
    ExpiryDate = json['ExpiryDate'];
    MedicinePhoto = json['MedicinePhoto'];
    SymptomId = json['SymptomId'];
    TabletsCount = json['TabletsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MedicineId'] = this.MedicineId;
    data['MedicineName'] = this.MedicineName;
    data['ExpiryDate'] = this.ExpiryDate;
    data['MedicinePhoto'] = this.MedicinePhoto;
    data['SymptomId'] = this.SymptomId;
    data['TabletsCount'] = this.TabletsCount;
    return data;
  }
}
