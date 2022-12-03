import 'package:flutter/material.dart';


import 'medicine_data_model.dart';

class MedicineListProvider with ChangeNotifier {
  List<medicineDataModel> _items = [];

  void addMedicineData(medicineDataModel MedicineData) {
    _items.add(MedicineData);
    notifyListeners();
  }

  List<medicineDataModel> get Medicines {
    return _items;
  }
}