import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:side_menu/Reusable/alert.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/date_picker.dart';
import 'package:side_menu/Reusable/toast.dart';
import 'package:side_menu/Routes/App_routes.dart';

import 'package:universal_io/io.dart';

import '../Database/database_helper.dart';

import '../modelClasses/medicine_data_model.dart';
import '../modelClasses/medicine_list_provider.dart';
import '../Reusable/alertInputTextfield.dart';
import '../Reusable/alert_date_picker.dart';
import '../Reusable/alert_textformfield.dart';

class AppShowAlertMedicineData extends StatelessWidget {
  AppShowAlertMedicineData({
    super.key,
    required this.message,
    required this.hintText,
    required this.errorMessage,
    required this.MedicinenameController,
    required this.ExpiryDateController,
    required this.input_type,
    required this.obsecuretext,
    // required this.node,
    required this.action,
    this.onEditingComplete,
    this.globalKey,
    required this.hintText1,
    required this.errorMessage1,
    //required this.MedicinenameControllerText,
  });
  final String message;
  final String hintText, hintText1, errorMessage, errorMessage1;
  final TextEditingController MedicinenameController, ExpiryDateController;
  final TextInputType input_type;
  final bool obsecuretext;
  // final FocusScopeNode node;
  final FocusScopeNode node = FocusScopeNode();
  final TextInputAction action;
  final VoidCallback? onEditingComplete;
  final GlobalKey? globalKey;

  @override
  Widget build(BuildContext context) {
    final _formkey1 = GlobalKey<FormState>();
    final _formkey2 = GlobalKey<FormState>();
    List<File> fileIs = [];
    final studentsStateProvider = Provider.of<MedicineListProvider>(context);
    MedicinenameController.text = "";
    ExpiryDateController.text = "";
    String? MedicinenameControllerText;
    return SingleChildScrollView(
      child: new Center(child: (() {
        print('OS: ${Platform.operatingSystem}');

        if (defaultTargetPlatform == TargetPlatform.android) {
          return new AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 150.0,
              ),
              backgroundColor: Colors.white,
              title: Text(message),
              content: Column(
                children: [
                  AlertTextFormField(
                      hintText: hintText,
                      nameController: MedicinenameController,
                      onChanged: (value) {
                        MedicinenameControllerText = value;
                      },
                      errorMessage: errorMessage,
                      input_type: input_type,
                      obsecuretext: obsecuretext,
                      node: node,
                      action: action,
                      onEditingComplete: onEditingComplete,
                      globalKey: _formkey1),
                  AlertdatePickerComponent(
                      hintText: hintText1,
                      nameController: ExpiryDateController,
                      errorMessage: errorMessage1,
                      obsecuretext: obsecuretext,
                      node: node,
                      action: action,
                      onEditingComplete: onEditingComplete,
                      globalKey: _formkey2),
                  TextButton(
                    onPressed: () async {
                      final result = await FilePicker.platform
                          .pickFiles(withReadStream: true, allowMultiple: true);
                      if (result == null) return;
                      fileIs = result.paths.map((path) => File(path!)).toList();
                      print('files length is ${fileIs.length}');
                    },
                    child: Text('Upload File'),
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: AppInputText(
                        text: 'Cancel',
                        colors: Colors.blue,
                        size: 20,
                        weight: FontWeight.bold)),
                TextButton(
                    onPressed: (() {
                      if (_formkey1.currentState!.validate() &&
                          _formkey2.currentState!.validate()) {
                        studentsStateProvider.addMedicineData(medicineDataModel(
                            medicineName: MedicinenameController.text,
                            ExpiryDate: ExpiryDateController.text,
                            medicineFiles: fileIs));
                        //MedicinesDataTable();
                        print('files are $fileIs');
                        print("data added successfully" +
                            studentsStateProvider.Medicines.length.toString());
                        Navigator.pop(context);
                      }
                    }),
                    child: AppInputText(
                        text: 'OK',
                        colors: Colors.blue,
                        size: 20,
                        weight: FontWeight.bold))
              ]);
        } else {
          return new CupertinoAlertDialog(
              title: Text(message),
              content: Column(children: [
                AlertTextFormField(
                    hintText: hintText,
                    nameController: MedicinenameController,
                    errorMessage: errorMessage,
                    input_type: input_type,
                    obsecuretext: obsecuretext,
                    node: node,
                    action: action,
                    onEditingComplete: onEditingComplete),
                AlertdatePickerComponent(
                    hintText: hintText1,
                    nameController: ExpiryDateController,
                    errorMessage: errorMessage1,
                    obsecuretext: obsecuretext,
                    node: node,
                    action: action,
                    onEditingComplete: onEditingComplete),
                     TextButton(
                    onPressed: () async {
                      final result = await FilePicker.platform
                          .pickFiles(withReadStream: true, allowMultiple: true);
                      if (result == null) return;
                      fileIs = result.paths.map((path) => File(path!)).toList();
                      print('files length is ${fileIs.length}');
                    },
                    child: Text('Upload File'),
                  )
              ]),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: AppInputText(
                        text: 'Cancel',
                        colors: Colors.blue,
                        size: 20,
                        weight: FontWeight.bold)),
                TextButton(onPressed: (() {
                      if (_formkey1.currentState!.validate() &&
                          _formkey2.currentState!.validate()) {
                        studentsStateProvider.addMedicineData(medicineDataModel(
                            medicineName: MedicinenameController.text,
                            ExpiryDate: ExpiryDateController.text,
                            medicineFiles: fileIs));
                        //MedicinesDataTable();
                        print('files are $fileIs');
                        print("data added successfully" +
                            studentsStateProvider.Medicines.length.toString());
                        Navigator.pop(context);
                      }
                    }),
                    child: AppInputText(
                        text: 'OK',
                        colors: Colors.blue,
                        size: 20,
                        weight: FontWeight.bold))
              ]);
        }
      })()),
    );
  }
}
