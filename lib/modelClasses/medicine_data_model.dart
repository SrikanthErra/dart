import 'dart:io';

class medicineDataModel {
  final String medicineName;
  final String ExpiryDate;
  final List<File> medicineFiles;
  final String TabletCount;
  medicineDataModel(
      {required this.medicineFiles,
      required this.medicineName,
      required this.ExpiryDate,
      required this.TabletCount});
}
