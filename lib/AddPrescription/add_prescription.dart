import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:side_menu/Reusable/alert_for_medicineData.dart';
import 'package:side_menu/Reusable/app_input_dropdown.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/date_picker.dart';
import 'package:side_menu/modelClasses/familyNamesModel.dart';
import 'package:side_menu/modelClasses/family_list_names_provider.dart';
import 'package:side_menu/modelClasses/medicine_list_provider.dart';
import 'package:side_menu/Reusable/button_component.dart';

import '../Database/database_helper.dart';
import '../appColor.dart';

class addPrescription extends StatefulWidget {
  const addPrescription({super.key});

  @override
  State<addPrescription> createState() => _addPrescriptionState();
}

class _addPrescriptionState extends State<addPrescription> {
  TextEditingController _famName = TextEditingController();
  TextEditingController _medicineName = TextEditingController();
  TextEditingController _symptom = TextEditingController();
  TextEditingController _expiryDate = TextEditingController();
  TextEditingController _hospitalName = TextEditingController();
  TextEditingController _appointment = TextEditingController();
  TextEditingController _doctorName = TextEditingController();
  TextEditingController _reason = TextEditingController();
  TextEditingController MedicinenameController = TextEditingController();
  TextEditingController ExpiryDateController = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formkey3 = GlobalKey<FormState>();
  final _formkey4 = GlobalKey<FormState>();
  final _formkey5 = GlobalKey<FormState>();
  List<PlatformFile> files_list = [];
  FilePickerResult? result;

  List<String> famNamesList = [];

  String? selectedValue;

  dynamic placeholder = NetworkImage(
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg');

  //File? _image;
  @override
  Widget build(BuildContext context) {
    //fetchNextVisitData();
    final familyNamesStateProvider =
        Provider.of<FamilyListNamesProvider>(context);
    final medicineStateProvider = Provider.of<MedicineListProvider>(context);
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Add Prescription',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        //backgroundColor: Color.fromARGB(0, 21, 91, 110),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        AppInputTextfield(
                            hintText: 'Family Member Name',
                            nameController: _famName,
                            errorMessage: 'please enter family member name',
                            input_type: TextInputType.text,
                            obsecuretext: false,
                            node: _node,
                            action: TextInputAction.next,
                            onEditingComplete: () {
                              _node.nextFocus();
                            },
                            globalKey: _formkey1),
                        AppInputTextfield(
                            hintText: 'symptom ',
                            nameController: _symptom,
                            errorMessage: 'please enter symptom',
                            input_type: TextInputType.text,
                            obsecuretext: false,
                            node: _node,
                            action: TextInputAction.next,
                            onEditingComplete: () {
                              _node.nextFocus();
                            },
                            globalKey: _formkey2),
                      ]),

                      // ListView.builder(
                      //     scrollDirection: Axis.vertical,
                      //     shrinkWrap: true,
                      //     itemCount: files_list.length,
                      //     itemBuilder: (context, index) {
                      //       final file = files_list[index];
                      //       return buildFile(file);
                      //       //return Text('Hello');
                      //     }),
                      // TextButton(
                      //   onPressed: () async {
                      //     final result = await FilePicker.platform.pickFiles(
                      //         withReadStream: true, allowMultiple: true);
                      //     if (result == null) return;
                      //     //  final files = result.files;
                      //     //   print(
                      //     //   'file is $files'); //EDIT: THIS PROBABLY CAUSED YOU AN ERROR
                      //     /* textt = result.files.first.path.toString();
                      //     print("test is $textt"); */
                      //     //  files_list = result.files;
                      //     files_list = result.paths
                      //         .map((path) => File(path ?? "") as PlatformFile)
                      //         .toList();
                      //     print('files picked are $files_list');
                      //     // placeholder = FileImage(File());
                      //     setState(() {});
                      //   },
                      //   child: Text('Upload File'),
                      // )
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppInputText(
                                text: "Add Medicine",
                                colors: Colors.white,
                                size: 20,
                                weight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AppShowAlertMedicineData(
                                          message: 'Please enter Medicine data',
                                          hintText: 'Enter Medicine Name',
                                          hintText1: 'Enter Expiry Date',
                                          errorMessage:
                                              'Please enter medicine name',
                                          errorMessage1:
                                              'Please enter expiry date',
                                          MedicinenameController:
                                              MedicinenameController,
                                          ExpiryDateController:
                                              ExpiryDateController,
                                          input_type: TextInputType.text,
                                          obsecuretext: false,
                                          node: _node,
                                          action: TextInputAction.next,
                                          onEditingComplete: () {
                                            _node.nextFocus();
                                          },
                                          globalKey: _formkey5);
                                    });
                              },
                              child: SvgPicture.asset(
                                'assets/plus.svg',
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
              ),
              Card(
                color: AppColors.PRIMARY_COLOR_DARK,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    // color: AppColors.PRIMARY_COLOR_DARK,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: medicineStateProvider.Medicines.length,
                        itemBuilder: ((context, index) {
                          final details =
                              medicineStateProvider.Medicines[index];
                          return Card(
                            // color: AppColors.PRIMARY_COLOR_DARK,
                            child: Container(
                                // color: AppColors.PRIMARY_COLOR,
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppInputText(
                                        text: "Medicine Name: ",
                                        colors: Colors.black,
                                        size: 16,
                                        weight: FontWeight.normal),
                                    AppInputText(
                                        text: medicineStateProvider
                                            .Medicines[index].medicineName,
                                        colors: Colors.black,
                                        size: 16,
                                        weight: FontWeight.normal),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppInputText(
                                        text: "Expiry Date:: ",
                                        colors: Colors.black,
                                        size: 16,
                                        weight: FontWeight.normal),
                                    AppInputText(
                                        text: medicineStateProvider
                                            .Medicines[index].ExpiryDate,
                                        colors: Colors.black,
                                        size: 16,
                                        weight: FontWeight.normal),
                                  ],
                                ),
                                /*  AppInputText(text: "Medicine Name: " +
                                    medicineStateProvider
                                        .Medicines[index].medicineName, colors: Colors.black, size: 16, weight: FontWeight.normal),
                                   AppInputText(text: "Expiry Date: " +
                                    medicineStateProvider
                                        .Medicines[index].ExpiryDate, colors: Colors.black, size: 16, weight: FontWeight.normal), */
                              ],
                            )),
                          );
                        })),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    AppInputTextfield(
                      hintText: 'Hospital Name',
                      nameController: _hospitalName,
                      errorMessage: 'please enter hospital name',
                      input_type: TextInputType.text,
                      obsecuretext: false,
                      node: _node,
                      action: TextInputAction.next,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    datePickerComponent(
                      hintText: 'Date of Appointment',
                      nameController: _appointment,
                      errorMessage: 'Please enter appointment date',
                      obsecuretext: false,
                      node: _node,
                      action: TextInputAction.next,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    AppInputTextfield(
                      hintText: 'Doctor Name',
                      nameController: _doctorName,
                      errorMessage: 'please enter doctor name',
                      input_type: TextInputType.text,
                      obsecuretext: false,
                      node: _node,
                      action: TextInputAction.next,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    AppInputTextfield(
                      hintText: 'Reason for Appointment',
                      nameController: _reason,
                      errorMessage: 'please enter reason for appointment',
                      input_type: TextInputType.text,
                      obsecuretext: false,
                      node: _node,
                      action: TextInputAction.next,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    datePickerComponent(
                      hintText: 'Next Appointment Date',
                      nameController: _expiryDate,
                      errorMessage: 'Please enter next Appointment date',
                      obsecuretext: false,
                      node: _node,
                      action: TextInputAction.next,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    ButtonComponent(
                        onPressed: () {
                          if (_formkey1.currentState!.validate()) {}
                          if (_formkey2.currentState!.validate()) {}
                          if (_formkey3.currentState!.validate()) {}
                          if (_formkey4.currentState!.validate()) {}
                        },
                        buttonText: 'Submit'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return Container(
      width: 100,
      height: 100,
      child: InkWell(
        onTap: () => null,
        child: Container(
          width: 200,
          height: 200,
          child: ListTile(
            leading: (file.extension == 'jpg' || file.extension == 'png')
                ? Image.file(
                    File(file.path.toString()),
                    width: 80,
                    height: 80,
                  )
                : Container(
                    width: 80,
                    height: 80,
                  ),
            title: Text('${file.name}'),
            subtitle: Text('${file.extension}'),
            trailing: Text(
              '$size',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
// your code goes here
      fetchNextVisitData();
    });
  }

  fetchNextVisitData() async {
    final familyNamesStateProvider =
        Provider.of<FamilyListNamesProvider>(context, listen: false);
    DatabaseHelper _dbInstance = DatabaseHelper.instance;
    await _dbInstance.queryAllRows('FamilyList').then((value) {
      value.forEach((element) {
        print(element);
        familyNamesStateProvider.addFamilyNamesData(
            familyNamesDataModel(FamilyMemberName: element['name']));
      });
      familyNamesStateProvider.FamilyNames.forEach(
        (element) {
          print("names are ${element.FamilyMemberName}");
        },
      );
      print(
          'getdetails${familyNamesStateProvider.FamilyNames[0].FamilyMemberName}');
    });
  }
}

/*studentsStateProvider.addMedicineData(medicineDataModel(
                            medicineName: MedicinenameController.text,
                            ExpiryDate: ExpiryDateController.text)*/