import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:side_menu/Alerts/alert_for_medicineData.dart';
import 'package:side_menu/Dashboard/dashboard_gridview.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/date_picker.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/medicine_list_provider.dart';
import 'package:side_menu/Reusable/button_component.dart';
import '../Database/database_helper.dart';
import '../appColor.dart';
import 'package:side_menu/modelClasses/familyNamesModel.dart';
import 'package:side_menu/modelClasses/family_list_names_provider.dart';
import 'package:side_menu/Reusable/toast.dart';
import 'package:side_menu/modelClasses/database_modelClass/PrescriptionModel.dart';
import '../app_constants.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';

class addPrescription extends StatefulWidget {
  const addPrescription({super.key});

  @override
  State<addPrescription> createState() => _addPrescriptionState();
}

class _addPrescriptionState extends State<addPrescription> {
  TextEditingController _famName = TextEditingController();
  TextEditingController _medicineName = TextEditingController();
  TextEditingController _symptom = TextEditingController();
  TextEditingController _NextAppointmentDate = TextEditingController();
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

  List<String> famNamesList = [];
  String? selectedValue;
  int? selectedId;
  String? getIdName;
  dynamic placeholder = NetworkImage(
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg');

  //File? _image;
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            //focusColor: Colors.white,
                            dropdownColor: Colors.blueGrey,
                            decoration: InputDecoration(
                              labelText: 'Name of a Family member',
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: 'Please enter name',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                            ),

                            value: selectedValue,
                            items: familyNamesStateProvider.FamilyNames.map(
                                (item) => DropdownMenuItem<String>(
                                    value: item.FamilyMemberName,
                                    child: Text(
                                      item.FamilyMemberName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ))).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                                getId(selectedValue ?? "");
                              });
                              /* print('Id is $selectedId');
                              print('Result is ${familyNamesStateProvider.FamilyNames.map(
                                  (e) => e.FamilyMemberId)}'); */
                            },
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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
                                print('names are $famNamesList');
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
                                          //node: _node,
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
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: medicineStateProvider.Medicines.length,
                          itemBuilder: ((context, index) {
                            final details =
                                medicineStateProvider.Medicines[index];
                            //final details2 = medicineStateProvider.Medicines[index].medicineFiles[index];
                            return Card(
                              // color: AppColors.PRIMARY_COLOR_DARK,
                              child: Container(
                                  // color: AppColors.PRIMARY_COLOR,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            text: details.medicineName,
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
                                            text: details.ExpiryDate,
                                            colors: Colors.black,
                                            size: 16,
                                            weight: FontWeight.normal),
                                      ],
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: details.medicineFiles.length,
                                        itemBuilder: ((context, index) {
                                          final details2 =
                                              details.medicineFiles[index];
                                          return ListTile(
                                              leading: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  minWidth: 100,
                                                  minHeight: 260,
                                                  maxWidth: 104,
                                                  maxHeight: 264,
                                                ),
                                                child: (details2.path
                                                                .split('.')
                                                                .last ==
                                                            'jpg' ||
                                                        details2.path
                                                                .split('.')
                                                                .last ==
                                                            'png')
                                                    ? Image.file(
                                                        File(details2.path
                                                            .toString()),
                                                        /* width: 80,
                                                      height: 80, */
                                                      )
                                                    : SvgPicture.asset(
                                                        'assets/pdf.svg',
                                                        /* height: 30,
                                                      width: 30, */
                                                        //  color: Colors.white,
                                                      ),
                                              ),
                                              onTap: () {
                                                AppConstants.filePath =
                                                    details2.path.toString();
                                                print(AppConstants.filePath);
                                                Navigator.pushNamed(context,
                                                    AppRoutes.pdfViewer);
                                              }
                                              //  child: PdfView(path: fileName.path),

                                              //       SfPdfViewer.file(
                                              // File('storage/emulated/0/Download/flutter-succinctly.pdf')));

                                              );
                                        }))
                                  ])),
                            );
                          }),
                        ),
                      ],
                    ),
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
                      nameController: _NextAppointmentDate,
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
                          if (validateField()) {
                            SaveData(medicineStateProvider);
                            showToast("Prescription added Successfully");
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.dashboardGridview);
                          }
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

  void initState() {
    super.initState();
    getId(getIdName ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
// your code goes here
      fetchNextVisitData();
    });
  }

/* async {
                        await EasyLoading.show(
                            status: "Loading...",
                            maskType: EasyLoadingMaskType.black);
                        Navigator.pushNamed(
                            context, dashboardData.navigateApproute ?? "");
                      }, */
  fetchNextVisitData() async {
    //EasyLoading.show(status: "Loading...", maskType: EasyLoadingMaskType.black);
    final familyNamesStateProvider =
        await Provider.of<FamilyListNamesProvider>(context, listen: false);
    familyNamesStateProvider.FamilyNames.length = 0;
    if (familyNamesStateProvider.FamilyNames.length == 0) {
      DatabaseHelper _dbInstance = DatabaseHelper.instance;
      await _dbInstance.queryAllRows('FamilyList').then((value) {
        //  familyNamesStateProvider.removeFamilyNamesData;
        value.forEach((element) {
          print(element);
          print('get names ${familyNamesStateProvider.FamilyNames.length}');
          familyNamesStateProvider.addFamilyNamesData(familyNamesDataModel(
              FamilyMemberName: element['name'],
              FamilyMemberId: element['id']));
          print('Length is ${famNamesList.length}');
        });
      });
    }
    /* else{
      DatabaseHelper _dbInstance = DatabaseHelper.instance;
      await _dbInstance.queryAllRows('FamilyList').then((value) {
         familyNamesStateProvider.removeFamilyNamesData;
        value.forEach((element) {
          print(element);
          print('get names ${familyNamesStateProvider.FamilyNames.length}');
          familyNamesStateProvider.addFamilyNamesData(familyNamesDataModel(
              FamilyMemberName: element['name'],
              FamilyMemberId: element['id']));
              print('Length is ${famNamesList.length}');
        });
        
      });
    } */
    // List<String> famNamesList = [];
    // EasyLoading.dismiss();
  }

  Future<int> SaveData(MedicineListProvider medicineStateProvider) async {
    final PrescriptionAdded = PrescriptionModel(
        FamilyMemberId: selectedId,
        Symptom: _symptom.text,
        DoctorName: _doctorName.text,
        HospitalName: _hospitalName.text,
        DateOfAppointment: _appointment.text,
        ReasonForAppointment: _reason.text,
        NextAppointmentDate: _NextAppointmentDate.text);
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.insertInto(
        PrescriptionAdded.toJson(), DatabaseHelper.table2);
    print("data saved $saved");
    final SymptomEntries =
        await _databaseService.queryAllRows(DatabaseHelper.table2);
    print("Entries in Symptoms Table $SymptomEntries");
    //dynamic symptomID = GetSymptomId();
    final count = await _databaseService.queryRowLast("Symptoms");
    print("""last Symptoms ID is  $count""");
    MedicinesDataTable(count, medicineStateProvider);
    return saved;
  }

  MedicinesDataTable(
      int count, MedicineListProvider medicineStateProvider) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final MedicineLength = (medicineStateProvider.Medicines.length);
    print("I am Printing $MedicineLength");
    for (final medicine in medicineStateProvider.Medicines) {
      String name = medicine.medicineName;
      print("I am Printing: $name");
      //for (var ii; ii < MedicineLength; ii++) {
      final MedicineTableData = MedicineModel(
          // MedicineName: medicineStateProvider.Medicines[ii].medicineName,
          // ExpiryDate: medicineStateProvider.Medicines[ii].ExpiryDate,
          MedicineName: medicine.medicineName,
          ExpiryDate: medicine.ExpiryDate,
          MedicinePhoto: medicine.medicineFiles.toString(),
          SymptomId: count);
      final saved = await _databaseService.insertInto(
          MedicineTableData.toJson(), DatabaseHelper.table3);
      print("data saved $saved");
      final MedicineEntries =
          await _databaseService.queryAllRows(DatabaseHelper.table3);
      print("Entries in Medicine Table $MedicineEntries");
    }
    medicineStateProvider.Medicines.clear();
    /* Future<int> GetSymptomId() async {
      final DatabaseHelper _databaseService = DatabaseHelper.instance;
      final count = await _databaseService.queryRowLast("Symptoms");
      print("""last Symptoms ID is  $count""");
      return count;
    } */
  }

  bool validateField() {
    if (_formkey2.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  /* getId(String name) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.userId(DatabaseHelper.table, name);
    print("data saved ${saved}");
  } */
  getId(String name) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.userId(DatabaseHelper.table, name);
    print("data saved ${saved}");
    selectedId = saved;
    print('Id selected is $selectedId');
  }
  /*  LoginCall(String phoneNumber, String mpin) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.queryRowCountforMpinValidate(
        DatabaseHelper.table, phoneNumber);
    print("data saved ${saved}");
    mpin_value = saved[0];
    if (mpin_value['mpin'] == mpin) {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboardGridview);
    } else {
      showAlert('Please Enter Valid MPIN');
    } */
}
