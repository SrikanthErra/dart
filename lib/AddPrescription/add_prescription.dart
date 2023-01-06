import 'dart:io';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:side_menu/Alerts/alert_for_medicineData.dart';
import 'package:side_menu/Constants/StringConstants.dart';
import 'package:side_menu/Constants/appColor.dart';
import 'package:side_menu/Constants/assetsPath.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/date_picker.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/medicine_list_provider.dart';
import 'package:side_menu/Reusable/button_component.dart';
import '../Constants/TextStyles.dart';
import '../Database/database_helper.dart';
import 'package:side_menu/modelClasses/familyNamesModel.dart';
import 'package:side_menu/modelClasses/family_list_names_provider.dart';
import 'package:side_menu/Reusable/toast.dart';
import 'package:side_menu/modelClasses/database_modelClass/PrescriptionModel.dart';
import '../Constants/app_constants.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';
import '../modelClasses/symptoms_model.dart';

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
  TextEditingController TabletCountController = TextEditingController();
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
  //MasterSymptomTable required parameters
  late TextEditingController textEditingController;
  String? selectedSymptomValue;
  int selectedSymptomId = 0;
  bool? flag;
  bool stag = false;
  bool? vis;
  //static List<SymptomsModelClass> symptomsTableData = [];
  // List<Map<String, dynamic>> SymptomsDataList = [{}];
  List<String> SymptomsDataList = [];

  List<File> Uploadedfiles = [];
  /* List<File> UploadedImagefiles = [];
  List<File> UploadedGalleryfiles = []; */
  List<String> _filespicked = [];
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    //fetchNextVisitData();
    final familyNamesStateProvider =
        Provider.of<FamilyListNamesProvider>(context);
    final medicineStateProvider = Provider.of<MedicineListProvider>(context);
    // Uploadedfiles = UploadedImagefiles + UploadedGalleryfiles;
    /* final PrescriptionStateProvider =
        Provider.of<PrescriptionListProvider>(context); */
    // medicineStateProvider.Medicines.length = 0;
    return Scaffold(
      //resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: Text(
          strings.DashBoard_AddPresc,
          style: subHeaderStyle,
        ),
        centerTitle: true,
        //backgroundColor: Color.fromARGB(0, 21, 91, 110),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.Background),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
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
                              labelText: strings.Presc_LabelMemName,
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: strings.Presc_MemNameHint,
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
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            //color: Colors.amber,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Autocomplete<String>(
                              onSelected: (String selectedItem) {
                                selectedSymptomValue = selectedItem;
                                if (selectedSymptomValue ==
                                    strings.Presc_OtherSymp) {
                                  print('Hello');
                                  setState(() {
                                    flag = true;
                                  });
                                } else {
                                  setState(() {
                                    flag = false;
                                    getMasterSymptomId(
                                        selectedSymptomValue ?? '');
                                    print('id selected $selectedSymptomId');
                                  });
                                }
                              },
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController
                                      fieldTextEditingController,
                                  FocusNode focusNode,
                                  VoidCallback onFieldSubmitted) {
                                textEditingController =
                                    fieldTextEditingController;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextFormField(
                                    controller: fieldTextEditingController,
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                        hintText: strings.Presc_Hint_Symp,
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                    focusNode: focusNode,
                                    style: TextStyle(color: Colors.white),
                                    onFieldSubmitted: (String value) {
                                      onFieldSubmitted();
                                      print(
                                          'text is ${textEditingController.text}');
                                      print(
                                          'You just typed a new entry  $value');
                                    },
                                  ),
                                );
                              },
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return Iterable<String>.empty();
                                } else {
                                  return SymptomsDataList.where((String item) {
                                    final result = item
                                        .toLowerCase()
                                        .startsWith(textEditingValue.text
                                            .toLowerCase());
                                    return result;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: flag ?? false,
                          child:
                              //AppInputTextfield(hintText: 'Please enter Symptoms', nameController: nameController, errorMessage: errorMessage, input_type: input_type, obsecuretext: obsecuretext, node: node, action: action, onEditingComplete: onEditingComplete)
                              Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: TextFormField(
                                      controller: _symptom,
                                      cursorColor: Colors.white,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                      decoration: InputDecoration(
                                          hintText:
                                              strings.Presc_Hint_EnterSymp,
                                          hintStyle:
                                              TextStyle(color: Colors.white)
                                          /* labelText: 'Enter Symptoms',
                                              labelStyle:
                                                   */
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (flag == true) {
                                        final result = SymptomsModelClass(
                                            MasterSymptom: _symptom.text);

                                        print('object ${result.MasterSymptom}');

                                        final DatabaseHelper _databaseService =
                                            DatabaseHelper.instance;
                                        final saved =
                                            await _databaseService.insertInto(
                                          result.toJson(),
                                          "SymptomMaster",
                                        );
                                      }
                                      print(selectedSymptomValue);
                                      getMasterSymptomId(
                                          selectedSymptomValue ?? '');
                                      _symptom.text = '';

                                      print('list is $SymptomsDataList');
                                      setState(() {
                                        flag = false;
                                        textEditingController.text = '';
                                      });
                                      SymptomsDataList = [];
                                      fetchData();
                                      /* await EasyLoading.show(

                                status: "Loading...",
                                maskType: EasyLoadingMaskType.black);
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.addPrescription); */
                                    },
                                    child: SvgPicture.asset(
                                      AssetPath.PlusIcon,
                                      height: 30,
                                      width: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppInputText(
                                text: strings.DashBoard_AddMed,
                                colors: Colors.white,
                                size: 18,
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
                                          message: strings.MedAlert_message,
                                          hintText:
                                              strings.MedAlert_hintEnterMed,
                                          hintText1:
                                              strings.MedAlert_hintExpDate,
                                          hintText2:
                                              strings.MedAlert_hintTabletsCount,
                                          errorMessage:
                                              strings.MedAlert_errorMedName,
                                          errorMessage1:
                                              strings.MedAlert_errorExpDate,
                                          errorMessage2: strings
                                              .MedAlert_errorTabletsCount,
                                          MedicinenameController:
                                              MedicinenameController,
                                          ExpiryDateController:
                                              ExpiryDateController,
                                          TabletCountController:
                                              TabletCountController,
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
                                AssetPath.PlusIcon,
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
              Container(
                // color: AppColors.PRIMARY_COLOR_DARK,
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: medicineStateProvider.Medicines.length,
                      itemBuilder: ((context, index) {
                        final details = medicineStateProvider.Medicines[index];

                        //final details2 = medicineStateProvider.Medicines[index].medicineFiles[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: AppColors.navy, width: 1),
                            ),
                            color: Colors.white,
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      width: 120,
                                      height: 110,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Image.file(
                                          File(details.medicineFiles ?? ''),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: AppInputText(
                                            text: details.medicineName,
                                            colors: AppColors.navy,
                                            size: 16,
                                            weight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: AppInputText(
                                                  text: strings.Med_ExpDate,
                                                  colors: AppColors.navy,
                                                  size: 16,
                                                  weight: FontWeight.normal),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: AppInputText(
                                                  text: details.ExpiryDate,
                                                  colors: AppColors.navy,
                                                  size: 16,
                                                  weight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: AppInputText(
                                                  text: strings.Med_TabletCount,
                                                  colors: AppColors.navy,
                                                  size: 16,
                                                  weight: FontWeight.normal),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: AppInputText(
                                                  text: details.TabletsCount,
                                                  colors: AppColors.navy,
                                                  size: 16,
                                                  weight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    AppInputTextfield(
                      hintText: strings.Presc_Hint_hospName,
                      nameController: _hospitalName,
                      errorMessage: strings.Presc_error_hospName,
                      input_type: TextInputType.text,
                      obsecuretext: false,
                      node: _node,
                      action: TextInputAction.next,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    datePickerComponent(
                      hintText: strings.Presc_Hint_AppointmentDate,
                      nameController: _appointment,
                      errorMessage: strings.Presc_error_AppointmentDate,
                      obsecuretext: false,
                      node: _node,
                      action: TextInputAction.next,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    AppInputTextfield(
                      hintText: strings.Presc_Hint_DrName,
                      nameController: _doctorName,
                      errorMessage: strings.Presc_error_DrName,
                      input_type: TextInputType.text,
                      obsecuretext: false,
                      node: _node,
                      action: TextInputAction.next,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    AppInputTextfield(
                      hintText: strings.Presc_Hint_AppointmentReason,
                      nameController: _reason,
                      errorMessage: strings.Presc_error_AppointmentReason,
                      input_type: TextInputType.text,
                      obsecuretext: false,
                      node: _node,
                      action: TextInputAction.next,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    datePickerComponent(
                      hintText: strings.Presc_Hint_NextAppointmentDate,
                      nameController: _NextAppointmentDate,
                      errorMessage: strings.Presc_error_NextAppointmentDate,
                      obsecuretext: false,
                      node: _node,
                      action: TextInputAction.next,
                      onEditingComplete: () {
                        _node.nextFocus();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Visibility(
                        visible: vis ?? false,
                        child: SizedBox(
                          height: 80,
                          // width: 80,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              // physics: NeverScrollableScrollPhysics(),
                              itemCount: Uploadedfiles.length,
                              itemBuilder: ((context, index) {
                                print('Hello world');
                                final res = Uploadedfiles[index];
                                /*  final details3 = PrescriptionStateProvider
                                    .prescFiles[index].PrescFilesList!; */
                                return SingleChildScrollView(
                                  child: Stack(children: [
                                    Container(
                                      child: (res.path.split('.').last ==
                                                  'jpg' ||
                                              res.path.split('.').last == 'png')
                                          ? GestureDetector(
                                              onTap: () {
                                                showImageViewer(
                                                    context,
                                                    Image.file(
                                                      File(res.path),
                                                    ).image);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.file(
                                                    File(res.path.toString()),
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.fill),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                AppConstants.filePath =
                                                    res.path.toString();
                                                print(AppConstants.filePath);
                                                Navigator.pushNamed(context,
                                                    AppRoutes.pdfViewer);
                                              },
                                              child: SvgPicture.asset(
                                                  'assets/pdf.svg',
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.fill
                                                  //  color: Colors.white,
                                                  ),
                                            ),
                                    ),
                                    Positioned(
                                      //  top: 50,
                                      bottom: 75,
                                      left:
                                          70, //give the values according to your requirement
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                        child: GestureDetector(
                                          onTap: () {
                                            print(
                                                'hello ${Uploadedfiles[index]}');
                                            setState(() {
                                              Uploadedfiles.removeAt(index);
                                              print(Uploadedfiles);
                                              //Uploadedfiles = UploadedImagefiles + UploadedGalleryfiles;
                                            });
                                          },
                                          child: Center(
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        /* onPressed: () {
                                              setState(() {
                                                Uploadedfiles.removeAt(index);
                                              });
                                            }, */
                                      ),
                                    ),
                                    /* Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(Icons.close,color: Colors.red,),
                                    ) */
                                  ]),
                                );
                              })),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () async {
                              final result = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              if (result == null) return;
                              selectedImage = File(result.path);
                              setState(() {
                                Uploadedfiles.add(selectedImage!);
                                vis = true;
                              });
                              print(
                                  'files length is ${selectedImage.toString()}');
                            },
                            child: Text(strings.Presc_ImgCamUpload),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () async {
                              final result = await FilePicker.platform
                                  .pickFiles(
                                      withReadStream: true,
                                      allowMultiple: true);
                              if (result == null) return;
                              setState(() {
                                var parse = result.paths
                                    .map((path) => File(path!))
                                    .toList();
                                parse.forEach((element) {
                                  Uploadedfiles.add(element);
                                });
                                // Uploadedfiles.add(parse)
                                vis = true;
                              });

                              print('files length is ${Uploadedfiles.length}');
                            },
                            child: Text(strings.Presc_ImgGalleryUpload),
                          ),
                        ),
                      ],
                    ),
                    ButtonComponent(
                        onPressed: () async {
                          print('val is $selectedValue');
                          print('sym val $selectedSymptomValue');
                          print(
                              'med details ${medicineStateProvider.Medicines}');
                          if (validateInputs(
                                  medicineStateProvider.Medicines.length) !=
                              true) {
                          } else {
                            SaveData(medicineStateProvider);
                            showToast("Prescription added Successfully");
                            await EasyLoading.show(
                                status: "Loading...",
                                maskType: EasyLoadingMaskType.black);
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.dashboardGridview);
                          }
                        },
                        buttonText: strings.ButtonSubmit),
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
    // masterSympomDataInsert();
    //SymptomsDataList = [];final medicineStateProvider = Provider.of<MedicineListProvider>(context);
    getId(getIdName ?? '');
    fetchData();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
// your code goes here
      fetchNextVisitData();
      var medicineStateProvider =
          Provider.of<MedicineListProvider>(context, listen: false);
      medicineStateProvider.Medicines.clear();
    });
  }

  fetchNextVisitData() async {
    //EasyLoading.show(status: "Loading...", maskType: EasyLoadingMaskType.black);
    final familyNamesStateProvider =
        await Provider.of<FamilyListNamesProvider>(context, listen: false);
    familyNamesStateProvider.FamilyNames.length = 0;
    if (familyNamesStateProvider.FamilyNames.length == 0) {
      DatabaseHelper _dbInstance = DatabaseHelper.instance;
      await _dbInstance.queryAllRows(DatabaseHelper.table).then((value) {
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
  }

  Future<int> SaveData(MedicineListProvider medicineStateProvider) async {
    int result = 0;
    print('len of uploaded files is ${Uploadedfiles.length}');
    print(' confirm id $selectedSymptomId');
    print('symptom $selectedSymptomValue');
    if (Uploadedfiles.length == 0) {
      print('entered in if');

      final PrescriptionAdded = PrescriptionModel(
        FamilyMemberId: selectedId,
        Symptom: selectedSymptomValue,
        SymptomId: selectedSymptomId,
        DoctorName: _doctorName.text,
        HospitalName: _hospitalName.text,
        DateOfAppointment: _appointment.text,
        ReasonForAppointment: _reason.text,
        NextAppointmentDate: _NextAppointmentDate.text,
        PrescFiles: '',
      );
      final DatabaseHelper _databaseService = DatabaseHelper.instance;
      final saved = await _databaseService.insertInto(
          PrescriptionAdded.toJson(), DatabaseHelper.table2);
      print("data saved $saved");
      final SymptomEntries =
          await _databaseService.queryAllRows(DatabaseHelper.table2);
      print("Entries in Symptoms Table $SymptomEntries");
      //dynamic symptomID = GetSymptomId();
      final count = await _databaseService.queryRowLast("Prescription");
      print("""last SID is  $count""");
      /* final count =
          await _databaseService.selectId("Symptoms", selectedSymptomValue ?? '');
      print('last symptomId is $count'); */
      MedicinesDataTable(count, medicineStateProvider);
      result = saved;
      return saved;
    } else {
      print('entered in else');
      Uploadedfiles.forEach((element) {
        _filespicked.add(element.path.toString());
      });
      // for (int i = 0; i < Uploadedfiles.length; i++) {
      print('files picked are $_filespicked');
      final PrescriptionAdded = PrescriptionModel(
          FamilyMemberId: selectedId,
          Symptom: selectedSymptomValue,
          SymptomId: selectedSymptomId,
          DoctorName: _doctorName.text,
          HospitalName: _hospitalName.text,
          DateOfAppointment: _appointment.text,
          ReasonForAppointment: _reason.text,
          NextAppointmentDate: _NextAppointmentDate.text,
          //PrescFiles: pres.path,
          PrescFiles: _filespicked.toString());
      final DatabaseHelper _databaseService = DatabaseHelper.instance;
      final saved = await _databaseService.insertInto(
          PrescriptionAdded.toJson(), DatabaseHelper.table2);
      print("data saved $saved");
      final SymptomEntries =
          await _databaseService.queryAllRows(DatabaseHelper.table2);
      print("Entries in Symptoms Table $SymptomEntries");
      //dynamic symptomID = GetSymptomId();
      final count = await _databaseService.queryRowLast("Prescription");
      print("""last Symptoms ID is  $count""");
      print('path is ${Uploadedfiles}');
      /* final count =
          await _databaseService.selectId("Symptoms", selectedSymptomValue ?? '');
      print('last symptomId is $count'); */
      MedicinesDataTable(count, medicineStateProvider);
      result = saved;
      return saved;
      //}
    }
  }

  MedicinesDataTable(
      int count, MedicineListProvider medicineStateProvider) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final MedicineLength = (medicineStateProvider.Medicines.length);
    print("I am Printing $MedicineLength");
    print('count is $count');
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
          SId: count,
          TabletsCount: int.tryParse(medicine.TabletsCount));
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

  /*  bool validateField() {
    if (_formkey2.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  } */

  getId(String name) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.userId(DatabaseHelper.table, name);
    print("data saved ${saved}");
    selectedId = saved;
    print('Id selected is $selectedId');
  }

  getMasterSymptomId(String name) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.symptomId("SymptomMaster", name);
    print("data saved ${saved}");
    selectedSymptomId = saved;
    print('Id selected is $selectedSymptomId');
  }

  insertData() async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    await _databaseService.symptomData();
  }

  fetchData() async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final res = await _databaseService.queryAllRows("SymptomMaster");
    res.forEach((element) {
      element.entries.forEach((e) {
        SymptomsDataList.add(e.value.toString());
      });
    });

    print('object ${SymptomsDataList}');
    if (SymptomsDataList.length == 0) {
      insertData();
      print('entered');
      final res = await _databaseService.queryAllRows("SymptomMaster");
      res.forEach((element) {
        element.entries.forEach((e) {
          SymptomsDataList.add(e.value.toString());
        });
      });
      int index = SymptomsDataList.length;
      print(index);
      SymptomsDataList.add(strings.Presc_OtherSymp);
      // SymptomsDataList.insert((index), 'Others');
      print('Hello');
      print('list is $SymptomsDataList');
      return SymptomsDataList;
    } else {
      print('Feed me more');
      SymptomsDataList.add(strings.Presc_OtherSymp);
      return SymptomsDataList;
    }
  }

  validateInputs(int res) {
    if (selectedValue == null) {
      showToast("Please select Family member Name");
    } else if (selectedSymptomValue == null) {
      showToast("Please select Symptom");
    } else if (res == 0) {
      showToast("Please enter Medicine Details");
    } else {
      return true;
    }
  }
}
