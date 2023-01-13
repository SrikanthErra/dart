import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/Constants/assetsPath.dart';
import 'package:medicineinventory/Database/database_helper.dart';
import 'package:medicineinventory/Reusable/toast.dart';
import 'package:medicineinventory/Routes/App_routes.dart';
import 'package:sqflite/sqflite.dart';
import '../Constants/TextStyles.dart';
import '../CustomAlerts/WarningAlert.dart';
import '../Reusable/app_input_text.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';

class AllMedicineList extends StatefulWidget {
  const AllMedicineList({super.key});

  @override
  State<AllMedicineList> createState() => _AllMedicineListState();
}

class _AllMedicineListState extends State<AllMedicineList> {
  List<MedicineModel> MedList = [];
  String? MedName;
  int? SymId;
  String? ExpDate;
  int? MedCount;
  TextEditingController TabletsCountController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text(strings.Sidemenu_InvMed), centerTitle: true),
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
              /* AppInputText(
                  text: 'MedicinesList',
                  colors: Colors.white,
                  size: 15,
                  weight: FontWeight.bold), */
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: MedList.length,
                itemBuilder: (context, index) {
                  final MedicineList = MedList[index];
                  MedName = MedicineList.MedicineName;
                  ExpDate = MedicineList.ExpiryDate;
                  MedCount = MedicineList.TabletsCount;
                  //  SymId = MedicineList.SymptomId;
                  return Container(
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
                                vertical: 8.0, horizontal: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    strings.Med_TabletCount,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "$MedCount",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              insetPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 50,
                                                      vertical: 150),
                                              title: Text(strings
                                                  .MedAlert_hintTabletsCount),
                                              content: Column(children: [
                                                Form(
                                                  key: _formkey,
                                                  child: TextFormField(
                                                    obscureText: false,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    controller:
                                                        TabletsCountController,
                                                    decoration: InputDecoration(
                                                      hintText: strings
                                                          .MedAlert_hintTabletsCount,
                                                      hintStyle: TextStyle(
                                                          color: Colors.black),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      labelStyle: TextStyle(
                                                        color: Colors.black,
                                                        // color: node.hasFocus?Colors.amber:Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      labelText: strings
                                                          .Med_TabletCount,
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return strings
                                                            .MedAlert_hintTabletsCount;
                                                      }
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    if (_formkey.currentState!
                                                        .validate()) {
                                                      MedCount = int.tryParse(
                                                          TabletsCountController
                                                              .text);
                                                      DatabaseHelper.instance
                                                          .UpdateTabletCount(
                                                              MedCount,
                                                              MedicineList
                                                                  .MedicineId);
                                                      await EasyLoading.show(
                                                          status:
                                                              strings.Loader,
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
                                                  child: Text(
                                                      strings.ButtonSubmit),
                                                )
                                              ]),
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
              style: RowComponentHeaderTextStyle,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: RowComponentTextStyle,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMedicinesData();
  }

  Future<void> fetchMedicinesData() async {
    await DatabaseHelper.instance.queryAllRows('Medicines').then((value) {
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
        });
      });
    });
    MedList.forEach((element) {
      if (element.TabletsCount == 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return WarningAlert(
              title: '',
              descriptions:
                  "No tablets for Medicine: '${element.MedicineName}'...! Do you want to Delete?",
              img: Image.asset(AssetPath.WarningBlueIcon),
              Buttontext2: strings.Alerts_No,
              onButton2Pressed: () {
                Navigator.pop(context);
              },
              Buttontext1: strings.Alerts_Yes,
              onButton1Pressed: () async {
                DatabaseHelper.instance.delete(element.MedicineId!);
                Navigator.pushNamed(context, AppRoutes.dashboardGridview);
                await EasyLoading.show(
                    status: strings.Loader,
                    maskType: EasyLoadingMaskType.black);
              },
            );
          },
        );
      }
    });
  }
}
