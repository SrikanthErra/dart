class medicineDataModel {
  final String medicineName;
  final String ExpiryDate;
  final String? medicineFiles;
  final String TabletsCount;
  medicineDataModel(
      {required this.medicineFiles,
      required this.medicineName,
      required this.ExpiryDate,
      required this.TabletsCount});
}
