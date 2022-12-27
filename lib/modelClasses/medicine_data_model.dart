import 'dart:io';

import 'package:image_picker/image_picker.dart';

class medicineDataModel {
  final String medicineName;
  final String ExpiryDate;
  final File? medicineFiles;
  final String TabletsCount;
  medicineDataModel(
      {required this.medicineFiles,
      required this.medicineName,
      required this.ExpiryDate,
      required this.TabletsCount});
}
