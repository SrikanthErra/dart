import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/Reusable/app_input_text.dart';
import 'package:medicineinventory/Reusable/toast.dart';

import '../modelClasses/medicine_data_model.dart';
import '../modelClasses/medicine_list_provider.dart';
import '../Reusable/alert_date_picker.dart';
import '../Reusable/alert_textformfield.dart';
import 'package:permission_handler/permission_handler.dart';

class AppShowAlertMedicineData extends StatelessWidget {
  AppShowAlertMedicineData({
    super.key,
    required this.message,
    required this.hintText,
    required this.errorMessage,
    required this.MedicinenameController,
    required this.ExpiryDateController,
    required this.TabletCountController,
    required this.input_type,
    required this.obsecuretext,
    // required this.node,
    required this.action,
    this.onEditingComplete,
    this.globalKey,
    required this.hintText1,
    required this.errorMessage1,
    required this.errorMessage2,
    required this.hintText2,
    //required this.MedicinenameControllerText,
  });
  final String message;
  final String hintText,
      hintText1,
      hintText2,
      errorMessage,
      errorMessage1,
      errorMessage2;
  final TextEditingController MedicinenameController,
      ExpiryDateController,
      TabletCountController;
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
    final _formkey3 = GlobalKey<FormState>();
    //XFile? fileIs;
    XFile? fileIs;
    final studentsStateProvider = Provider.of<MedicineListProvider>(context);
    MedicinenameController.text = "";
    ExpiryDateController.text = "";
    TabletCountController.text = "";
    String? MedicinenameControllerText;
    int? TabletCountControllerText;
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
                  AlertTextFormField(
                      hintText: hintText2,
                      nameController: TabletCountController,
                      onChanged: (value) {
                        TabletCountControllerText = value as int?;
                      },
                      errorMessage: errorMessage2,
                      input_type: TextInputType.number,
                      obsecuretext: obsecuretext,
                      node: node,
                      action: action,
                      onEditingComplete: onEditingComplete,
                      globalKey: _formkey3),
                  TextButton(
                    onPressed: () async {
                      if (await checkallpermission_opencamera() == false) {
                        openAppSettings();
                      } else {
                        final result = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (result == null) return;
                        fileIs = result;
                        print('files length is ${fileIs.toString()}');
                      }
                    },
                    child: Text(strings.Presc_ImgCamUpload),
                  ),
                  TextButton(
                    onPressed: () async {
                      final result = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (result == null) return;
                      fileIs = result;
                      print('files length is ${fileIs.toString()}');
                    },
                    child: Text(strings.Presc_ImgGalleryUpload),
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
                    onPressed: (() async {
                      if (_formkey1.currentState!.validate() &&
                          _formkey2.currentState!.validate() &&
                          _formkey3.currentState!.validate() &&
                          fileIs != null) {
                        studentsStateProvider.addMedicineData(medicineDataModel(
                            medicineName: MedicinenameController.text,
                            ExpiryDate: ExpiryDateController.text,
                            medicineFiles: fileIs?.path,
                            TabletsCount: TabletCountController.text));
                        print('files are $fileIs');
                        print("data added successfully" +
                            studentsStateProvider.Medicines.length.toString());
                        await EasyLoading.show(
                            status: strings.Loader,
                            maskType: EasyLoadingMaskType.black);
                        Navigator.pop(context);
                        EasyLoading.dismiss();
                      } else {
                        showToast(strings.ToastMsg_uploadImg);
                      }
                    }),
                    child: AppInputText(
                        text: strings.Presc_Ok,
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
                    globalKey: _formkey1,
                    onEditingComplete: onEditingComplete),
                AlertdatePickerComponent(
                    hintText: hintText1,
                    nameController: ExpiryDateController,
                    errorMessage: errorMessage1,
                    obsecuretext: obsecuretext,
                    node: node,
                    action: action,
                    globalKey: _formkey2,
                    onEditingComplete: onEditingComplete),
                AlertTextFormField(
                    hintText: hintText2,
                    nameController: TabletCountController,
                    errorMessage: errorMessage2,
                    input_type: TextInputType.number,
                    obsecuretext: obsecuretext,
                    node: node,
                    action: action,
                    onEditingComplete: onEditingComplete,
                    globalKey: _formkey3),
                TextButton(
                  onPressed: () async {
                    if (await checkallpermission_opencamera() == false) {
                      openAppSettings();
                    } else {
                      final result = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (result == null) return;
                      fileIs = result;

                      print('files length is ${fileIs.toString()}');
                    }
                  },
                  child: Text(strings.Presc_ImgCamUpload),
                ),
                TextButton(
                  onPressed: () async {
                    final result = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (result == null) return;
                    fileIs = result;

                    print('files length is ${fileIs.toString()}');
                  },
                  child: Text(strings.Presc_ImgGalleryUpload),
                )
              ]),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: AppInputText(
                        text: strings.Presc_Cancel,
                        colors: Colors.blue,
                        size: 20,
                        weight: FontWeight.bold)),
                TextButton(
                    onPressed: (() async {
                      if (_formkey1.currentState!.validate() &&
                          _formkey2.currentState!.validate() &&
                          _formkey3.currentState!.validate() &&
                          fileIs != null) {
                        studentsStateProvider.addMedicineData(medicineDataModel(
                            medicineName: MedicinenameController.text,
                            ExpiryDate: ExpiryDateController.text,
                            medicineFiles: fileIs?.path,
                            //medicineFiles: '',
                            TabletsCount: TabletCountController.text));
                        print('files are $fileIs');
                        print("data added successfully" +
                            studentsStateProvider.Medicines.length.toString());
                        await EasyLoading.show(
                            status: strings.Loader,
                            maskType: EasyLoadingMaskType.black);
                        Navigator.pop(context);
                        EasyLoading.dismiss();
                      } else {
                        showToast(strings.ToastMsg_uploadImg);
                      }
                    }),
                    child: AppInputText(
                        text: strings.Presc_Ok,
                        colors: Colors.blue,
                        size: 20,
                        weight: FontWeight.bold))
              ]);
        }
      })()),
    );
  }
}

Future<bool> checkallpermission_opencamera() async {
  await [Permission.camera].request();
  var cameraStatus = await Permission.camera.status;
  print("Camera sssss: $cameraStatus");
  if (cameraStatus.isGranted) {
    print("PErmission granted");
    return true;
  } else if (cameraStatus.isPermanentlyDenied) {
    print("denied");
    await openAppSettings();
    return false;
  } else {
    showToast(
      "Provide Camera permission to use camera.",
    );
    // await openAppSettings();
    return false;
  }
}

/* Future<bool> checkallpermission_StoragePermission() async {
  await [
    Permission.storage,
  ].request();
  var storageStatus = await Permission.storage.status;
  if (storageStatus.isGranted) {
    return true;
  } else {
    showToast(
      "Provide Storage permission to upload files.",
    );
    await openAppSettings();
    return false;
  }
} */
