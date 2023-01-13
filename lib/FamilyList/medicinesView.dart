import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/Constants/assetsPath.dart';
import 'package:medicineinventory/Database/database_helper.dart';
import 'package:medicineinventory/Reusable/toast.dart';
import 'package:medicineinventory/Routes/App_routes.dart';
import '../CustomAlerts/WarningAlert.dart';
import '../Reusable/app_input_text.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({super.key});

  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  List<MedicineModel> MedList = [];
  List<MedicineModel> SearchMedList = [];
  String? MedName;
  int? SymId;
  int? presc_SId;
  String? ExpDate;
  int? MedCount;
  TextEditingController TabletsCountController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    presc_SId = ModalRoute.of(context)?.settings.arguments as dynamic;
    /* setState(() {
      SearchMedList = MedList;
    }); */
    print(presc_SId);
    print('medlist is $MedList');
    print('search $SearchMedList');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text(strings.familyList_Title), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.Background),
            fit: BoxFit.cover,
          ),
        ),
        //margin: EdgeInsets.symmetric(vertical: 20),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppInputText(
                  text: strings.familyList_MedList,
                  colors: Colors.white,
                  size: 15,
                  weight: FontWeight.bold),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,

                  //cursorHeight: 10,
                  //  TextStyle(color: Colors.white),
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: strings.SearchMedicine,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    /*  enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.white),   
                      ),   */
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: SearchMedList.length,
                itemBuilder: (context, index) {
                  final MedicineList = SearchMedList[index];
                  MedName = MedicineList.MedicineName;
                  ExpDate = MedicineList.ExpiryDate;
                  MedCount = MedicineList.TabletsCount;
                  //  SymId = MedicineList.SymptomId;
                  return MedicineList.TabletsCount == 0
                      ? GestureDetector(
                          child: Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                    BorderSide(color: Colors.black87, width: 1),
                              ),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  RowComponent(
                                    strings.Med_MedName,
                                    MedName,
                                  ),
                                  RowComponent(strings.Med_ExpDate, ExpDate),
                                  RowComponent(strings.Med_TabletCount,
                                      MedicineList.TabletsCount),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return WarningAlert(
                                  title: '',
                                  descriptions:
                                      "No tablets for Medicine: '${MedicineList.MedicineName}'...! Do you want to Delete?",
                                  img: Image.asset(AssetPath.WarningBlueIcon),
                                  Buttontext2: strings.Alerts_No,
                                  onButton2Pressed: () {
                                    Navigator.pop(context);
                                  },
                                  Buttontext1: strings.Alerts_Yes,
                                  onButton1Pressed: () async {
                                    DatabaseHelper.instance
                                        .delete(MedicineList.MedicineId!);
                                    Navigator.pushNamed(
                                        context, AppRoutes.dashboardGridview);
                                    await EasyLoading.show(
                                        status: strings.Loader,
                                        maskType: EasyLoadingMaskType.black);
                                    showToast(strings.ToastMsg_MedDeleted);
                                  },
                                );
                              },
                            );
                          },
                        )
                      : Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.black87, width: 1),
                            ),
                            color: Colors.white,
                            child: Column(
                              children: [
                                RowComponent(
                                  strings.Med_MedName,
                                  MedName,
                                ),
                                RowComponent(strings.Med_ExpDate, ExpDate),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          strings.Med_TabletCount,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "$MedCount",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 50.0,
                                                            vertical: 50.0),
                                                    title: Text(strings
                                                        .MedView_AlertMsg),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Form(
                                                              key: _formkey,
                                                              child:
                                                                  TextFormField(
                                                                obscureText:
                                                                    false,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                controller:
                                                                    TabletsCountController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText: strings
                                                                      .MedView_AlertMsg,
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  labelStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    // color: node.hasFocus?Colors.amber:Colors.blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  labelText: strings
                                                                      .Med_TabletCount,
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return strings
                                                                        .MedView_AlertMsg;
                                                                  }
                                                                },
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                if (_formkey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  MedCount = int
                                                                      .tryParse(
                                                                          TabletsCountController
                                                                              .text);
                                                                  DatabaseHelper
                                                                      .instance
                                                                      .UpdateTabletCount(
                                                                          MedCount,
                                                                          MedicineList
                                                                              .MedicineId);
                                                                  await EasyLoading.show(
                                                                      status: strings
                                                                          .Loader,
                                                                      maskType:
                                                                          EasyLoadingMaskType
                                                                              .black);
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      AppRoutes
                                                                          .dashboardGridview);
                                                                  showToast(strings
                                                                      .ToastMsg_TabletUpdated);
                                                                }
                                                              },
                                                              child: Text(strings
                                                                  .ButtonSubmit),
                                                            )
                                                          ]),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.edit)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      fetchMedicinedata(presc_SId ?? 0);
    });
  }

  fetchMedicinedata(int id) async {
    print('selected id is $id');
    await DatabaseHelper.instance
        .medicineList(strings.Db_MedTable, id)
        .then((value) {
      setState(() {
        MedList = [];
        value.forEach((element) {
          print('element is $element');
          MedList.add(MedicineModel(
              MedicineId: element["MedicineId"],
              ExpiryDate: element["ExpiryDate"],
              MedicineName: element["MedicineName"],
              MedicinePhoto: element["MedicinePhoto"],
              TabletsCount: element["TabletsCount"]));
          SearchMedList = MedList;
          print(' id ${id}');
        });
        /* if (id != 0) {
          print('list od med is $MedList');
          Navigator.pushNamed(context, AppRoutes.MedicineListView,
              arguments: MedList);
        } */
      });
    });
  }

  _runFilter(String enteredKeyword) {
    List<MedicineModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = MedList;
    } else {
      print(enteredKeyword);
      results = MedList.where((element) => element.MedicineName!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      SearchMedList = results;
      print(SearchMedList.length);
    });
  }

  //void fetchMedicinesData() {}
}
