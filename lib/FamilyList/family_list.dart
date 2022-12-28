import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_menu/Reusable/alert.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/Database/database_helper.dart';
import 'package:side_menu/app_constants.dart';
import 'package:side_menu/modelClasses/database_modelClass/PrescriptionModel.dart';
import 'package:side_menu/modelClasses/family_list_model.dart';
import 'package:side_menu/modelClasses/pass_name_from_famlist_to_prescriptionview.dart';
import 'package:side_menu/modelClasses/prescription_list_model.dart';

import '../Reusable/app_input_text.dart';
import '../modelClasses/familyNamesModel.dart';

class familyList extends StatefulWidget {
  const familyList({super.key});

  @override
  State<familyList> createState() => _familyListState();
}

class _familyListState extends State<familyList> {
  List<familyListModel> famList = [];
  List<int> presCount = [];
  List<PrescriptionModel> prescList = [];
  int? selectedId;
  //int PrescriptionCount = 0;
  String? FamilyMemeber = "";
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
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
                  text: 'Family List',
                  colors: Colors.white,
                  size: 15,
                  weight: FontWeight.bold),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: famList.length,
                itemBuilder: (context, index) {
                  final familylist = famList[index];
                  //  print(familylist);
                  FamilyMemeber = familylist.Name;
                  //  print(FamilyMemeber);
                  final PrescriptionCount = familylist.Count;
                  return Container(
                    child: GestureDetector(
                      onTap: () {
                        print('name clicked is ${familylist.Name}');
                        getId(familylist.Name ?? '');
                        
                        // fetchdata();
                        // AppConstants.passFamilyMemberName = familylist.Name ?? '';
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.black87, width: 1),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [
                              RowComponent(
                                "Name of the family Member",
                                FamilyMemeber,
                              ),
                              RowComponent(
                                "Prescription Count",
                                PrescriptionCount,
                              ),
                            ],
                          ),
                        ),
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

  void initState() {
    super.initState();
    fetchNextVisitData();
  }

  fetchNextVisitData() async {
    DatabaseHelper _dbInstance = DatabaseHelper.instance;
    await _dbInstance.queryAllRows('FamilyList').then((value) {
      setState(() {
        value.forEach((element) {
          famList
              .add(familyListModel(Name: element['name'], id: element['id']));
        });
      });
    });
    int i = 0;
    while (i < famList.length) {
      final PresCount =
          await _dbInstance.queryPresCount('Prescription', famList[i].id ?? 0);
      presCount.add(PresCount);
      i++;
    }
    print(presCount);
    int j = 0;
    while (j < presCount.length) {
      setState(() {
        famList[j].Count = presCount[j];
      });
      j++;
    }
  }

  getId(String name) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.userId(DatabaseHelper.table, name);
    print("data saved ${saved}");
    selectedId = saved;
    print('Id selected is $selectedId');
    fetchdata(selectedId ?? 0);
  }

  fetchdata(int id) async {
   // print('selected id is $id');
   await DatabaseHelper.instance.prescList('Prescription',id).then((value) {
      setState(() {
        prescList = [];
        value.forEach((element) {
          print('element is $element');
          prescList.add(
            PrescriptionModel(
              SId: element["SId"],
              Symptom: element["Symptom"],
              DoctorName: element["DoctorName"],
              HospitalName: element["HospitalName"],
              DateOfAppointment: element["DateOfAppointment"],
              ReasonForAppointment: element["ReasonForAppointment"],
              SymptomId: element["SymptomId"],
            ),
          );
          print(' id ${id}');
          print('length id ${prescList.length}');
        });
        if (prescList.length != 0) {
          Navigator.pushNamed(context, AppRoutes.prescriptionList,
              arguments: prescList
              // arguments:tappedNames(FamilyMemberName: familylist.Name!)
              );
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AppShowAlert(message: 'No Prescription data found');
              });
        }
      });
      //  print('data saved is ${saved}');
    });
  }
}
