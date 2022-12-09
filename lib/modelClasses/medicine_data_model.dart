import 'dart:io';

class medicineDataModel {
  final String medicineName;
  final String ExpiryDate;
  final List<File> medicineFiles;
  medicineDataModel({ required this.medicineFiles, required this.medicineName, required this.ExpiryDate});
}
