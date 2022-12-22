import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_menu/Database/database_helper.dart';
import 'package:side_menu/Reusable/toast.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:sqflite/sqflite.dart';
import '../Reusable/app_input_text.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({super.key});

  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  List<MedicineModel> MedList = [];
  String? MedName;
  int? SymId;
  String? ExpDate;
  int? MedCount;
  TextEditingController TabletsCountController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    MedList = ModalRoute.of(context)?.settings.arguments as dynamic;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text('Prescription List'), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_bg.png"),
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
                  text: 'MedicinesList',
                  colors: Colors.white,
                  size: 15,
                  weight: FontWeight.bold),
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
                            "Medicine Name",
                            MedName,
                          ),
                          RowComponent("Expiry Date", ExpDate),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Tablets Count",
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
                                              title: Text("Enter Tablet Count"),
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
                                                      hintText:
                                                          "Enter Tablet Count",
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
                                                      labelText:
                                                          "Tablets Count",
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter Tablets Count";
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
                                                          status: "Loading...",
                                                          maskType:
                                                              EasyLoadingMaskType
                                                                  .black);
                                                      Navigator.pushNamed(
                                                          context,
                                                          AppRoutes
                                                              .dashboardGridview);
                                                      showToast(
                                                          "Tablet Count Updated Successfully");
                                                    }
                                                  },
                                                  child: Text("Submit"),
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

/*   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMedicinesData();
  }

  void fetchMedicinesData() {} */
}
