import 'package:flutter/material.dart';


import 'medicine_data_model.dart';

class MedicineListProvider with ChangeNotifier {
  List<medicineDataModel> _items = [];
  // List<medicineDataModel> medicineFilesList = [];
  void addMedicineData(medicineDataModel MedicineData) {
    _items.add(MedicineData);
    notifyListeners();
  }

  List<medicineDataModel> get Medicines {
    return _items;

  }
  void clearMedicineData(medicineDataModel MedicineData) {
    _items.clear();
    notifyListeners();
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}