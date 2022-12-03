import 'package:flutter/material.dart';
import 'package:side_menu/modelClasses/familyNamesModel.dart';


import 'medicine_data_model.dart';

class FamilyListNamesProvider with ChangeNotifier {
  List<familyNamesDataModel> _items = [];

  addFamilyNamesData(familyNamesDataModel familyNamesData) {
    _items.add(familyNamesData);
    notifyListeners();
  }

  List<familyNamesDataModel> get FamilyNames {
    return _items;
  }
  
}