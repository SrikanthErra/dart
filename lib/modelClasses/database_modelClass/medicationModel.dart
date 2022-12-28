class MedicineModel {
  int? MedicineId;
  String? MedicineName;
  String? ExpiryDate;
  String? MedicinePhoto;
  int? TabletsCount;
  int? SId;

  MedicineModel({
    this.MedicineId,
    this.MedicineName,
    this.ExpiryDate,
    this.MedicinePhoto,
    this.SId,
    this.TabletsCount,
  });

  MedicineModel.fromJson(Map<String, dynamic> json) {
    MedicineId = json['MedicineId'];
    MedicineName = json['MedicineName'];
    ExpiryDate = json['ExpiryDate'];
    MedicinePhoto = json['MedicinePhoto'];
    SId = json['SId'];
    TabletsCount = json['TabletsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MedicineId'] = this.MedicineId;
    data['MedicineName'] = this.MedicineName;
    data['ExpiryDate'] = this.ExpiryDate;
    data['MedicinePhoto'] = this.MedicinePhoto;
    data['SId'] = this.SId;
    data['TabletsCount'] = this.TabletsCount;
    return data;
  }
}
