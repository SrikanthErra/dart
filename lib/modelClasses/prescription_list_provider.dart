import 'package:flutter/material.dart';
import 'package:side_menu/modelClasses/familyNamesModel.dart';
import 'package:side_menu/modelClasses/presc_files_model.dart';

import 'medicine_data_model.dart';

class PrescriptionListProvider with ChangeNotifier {
  List<prescFilesModel> _items = [];

  addFamilyNamesData(prescFilesModel prescFilesData) {
    _items.add(prescFilesData);
    notifyListeners();
  }

 removeFamilyNamesData(prescFilesModel prescFilesData) {
    _items = [];
    notifyListeners();
  }

  List<prescFilesModel> get prescFiles {
    return _items;
  }
}