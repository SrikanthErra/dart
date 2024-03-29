import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/Constants/appColor.dart';
import 'package:medicineinventory/Constants/assetsPath.dart';
import 'package:medicineinventory/CustomAlerts/customAlerts.dart';
import 'package:medicineinventory/Reusable/alert.dart';
import 'package:medicineinventory/Routes/App_routes.dart';
import 'package:medicineinventory/Database/database_helper.dart';
import 'package:medicineinventory/Constants/app_constants.dart';
import 'package:medicineinventory/modelClasses/database_modelClass/PrescriptionModel.dart';
import 'package:medicineinventory/modelClasses/family_list_model.dart';
import 'package:medicineinventory/modelClasses/total_presc_view_model.dart';
import '../Constants/TextStyles.dart';
import '../Reusable/app_input_text.dart';

class familyList extends StatefulWidget {
  const familyList({super.key});

  @override
  State<familyList> createState() => _familyListState();
}

class _familyListState extends State<familyList> {
  List<familyListModel> famList = [];
  List<int> presCount = [];
  List<PrescriptionModel> prescList = [];
  List<totalPrescViewModel> totalPresc = [];
  int? selectedId;
  //int PrescriptionCount = 0;
  String? FamilyMemeber = "";
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
                  text: strings.DashBoard_FamList,
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
                                strings.familyList_HeaderFamName,
                                FamilyMemeber,
                              ),
                              RowComponent(
                                strings.familyList_HeaderPrescCount,
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

  void initState() {
    super.initState();
    fetchNextVisitData();
  }

  fetchNextVisitData() async {
    DatabaseHelper _dbInstance = DatabaseHelper.instance;
    await _dbInstance.queryAllRows(strings.Db_FamTable).then((value) {
      setState(() {
        value.forEach((element) {
          famList
              .add(familyListModel(Name: element['name'], id: element['id']));
        });
      });
    });
    int i = 0;
    while (i < famList.length) {
      final PresCount = await _dbInstance.queryPresCount(
          strings.Db_PrescTable, famList[i].id ?? 0);
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

    AppConstants.famMemId = selectedId ?? 0;
    print('app const is ${AppConstants.famMemId}');

    fetchdata(selectedId ?? 0, name);
  }

  /* fetchAllPresData(int id) async {
    await DatabaseHelper.instance.viewTotalPres(id).then((value) {
      setState(() {
        totalPresc = [];
        value.forEach((element) {
          print('data is $element');
          totalPresc.add(totalPrescViewModel(
            name: element['name'],
            DoctorName: element['DoctorName'],
            DateOfAppointment: element['DateOfAppointment'],
            ExpiryDate: element['ExpiryDate'],
            HospitalName: element['HospitalName'],
            MedicineName: element['MedicineName'],
            MedicinePhoto: element['MedicinePhoto'],
            NextAppointmentDate: element['NextAppointmentDate'],
            PrescFiles: element['PrescFiles'],
            ReasonForAppointment: element['ReasonForAppointment'],
            Symptom: element['Symptom'],
            TabletsCount: element['TabletsCount'],
          ));
        });
      });
    });
  } */

  /*
     fetchdata() async {
    await DatabaseHelper.instance.viewMed().then((value) {
      setState(() {
        viewMedList = [];
        value.forEach((element) {
          print('element is $element');
          viewMedList.add(viewMedicineModel(
            Symptom: element["Symptom"],
            MedicineName: element["MedicineName"],
            ExpiryDate: element["ExpiryDate"],
            /*  ExpiryDate: element["ExpiryDate"],
            MedicineName: element["MedicineName"],
            MedicinePhoto: element["MedicinePhoto"], */
          ));
          print(' id ${viewMedList}');
          viewSearchMedList = viewMedList;
        });
      });
    });
  }
  */

  fetchdata(int id, String name) async {
    // print('selected id is $id');
    await DatabaseHelper.instance.prescList('Prescription', id).then((value) {
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
              arguments: FamilyArguments(prescList, name, id)
              // arguments:tappedNames(FamilyMemberName: familylist.Name!)
              );
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                    title: 'Prescription Data',
                    descriptions: strings.familyList_AlertPresc,
                    Buttontext: strings.Presc_Ok,
                    img: Image.asset(AssetPath.WarningBlueIcon),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    bgColor: AppColors.navy);
              });
        }
      });
      //  print('data saved is ${saved}');
    });
  }
}

class FamilyArguments {
  final List<PrescriptionModel> prescList;
  final String name;
  final int id;
  FamilyArguments(this.prescList, this.name, this.id);
}
