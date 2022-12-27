import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/pass_name_from_famlist_to_prescriptionview.dart';
import 'package:side_menu/modelClasses/prescription_list_model.dart';

import '../Database/database_helper.dart';
import '../Reusable/app_input_text.dart';
import '../modelClasses/database_modelClass/PrescriptionModel.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';

class prescriptionList extends StatefulWidget {
  const prescriptionList({super.key});

  @override
  State<prescriptionList> createState() => _prescriptionListState();
}

class _prescriptionListState extends State<prescriptionList> {
  //List<PrescriptionModel> prescList = [];
  String? DoctorName;
  String? PrescriptionDate;
  String? MedicineName;
  String? Symptoms;
  int? symptomId;
  int? selectedId;
  String? getIdUsingName;
  List<PrescriptionModel> prescList = [];
  List<MedicineModel> MedList = [];
  @override
  Widget build(BuildContext context) {
    prescList = ModalRoute.of(context)?.settings.arguments as dynamic;
    return Scaffold(
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
        child: prescList.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: AppInputText(
                  colors: Colors.white,
                  size: 12,
                  text: 'No Data Added.....:(',
                  weight: FontWeight.bold,
                ),
              )
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppInputText(
                        text: 'Family Member Name',
                        colors: Colors.white,
                        size: 15,
                        weight: FontWeight.bold),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: prescList.length,
                      itemBuilder: (context, index) {
                        final prescriptionlist = prescList[index];
                        DoctorName = prescriptionlist.DoctorName;
                        PrescriptionDate = prescriptionlist.DateOfAppointment;
                        Symptoms = prescriptionlist.Symptom;
                        symptomId = prescriptionlist.SymptomId;
                        return Container(
                          child: GestureDetector(
                            onTap: () {
                              print(
                                  'symptom id is ${prescriptionlist.SymptomId}');
                              fetchdata(prescriptionlist.SymptomId ?? 0);

                              /* Navigator.pushNamed(
                                  context, AppRoutes.MedicineListView); */
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                    BorderSide(color: Colors.black87, width: 1),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  children: [
                                    RowComponent(
                                      "Doctor Name",
                                      DoctorName,
                                    ),
                                    RowComponent(
                                      "Prescription Date",
                                      PrescriptionDate,
                                    ),
                                    RowComponent(
                                      "Symptoms",
                                      Symptoms,
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

  fetchdata(int id) async {
    print('selected id is $id');
    await DatabaseHelper.instance.medicineList('Medicines', id).then((value) {
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
          print(' id ${id}');
        });
        if (id != 0) {
          print('list od med is $MedList');
          Navigator.pushNamed(context, AppRoutes.MedicineListView,
              arguments: MedList);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
  /* void initState() {
    super.initState();
    // getId(getIdUsingName ?? '');
    print('hello world');
    fetchdata();
  } */

  /*
  LoginCall(String phoneNumber, String mpin) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.queryRowCountforMpinValidate(
        DatabaseHelper.table, phoneNumber);
    print("data saved ${saved}");
    mpin_value = saved[0];
  */
  /* fetchdata() async {
    DatabaseHelper.instance
        .prescList('Symptoms', selectedId ?? 0)
        .then((value) {
      setState(() {
        value.forEach((element) {
        //  print(element);
          prescList.add(
              PrescriptionModel(
                Symptom: element["Symptom"],
                DoctorName: element["DoctorName"],
                HospitalName: element["HospitalName"],
                DateOfAppointment: element["DateOfAppointment"],
                ReasonForAppointment: element["ReasonForAppointment"],
              ),
            );
            print(prescList.length);
        });
      });
    //  print('data saved is ${saved}');
    });
  } */

  /*  fetchdata() async {
    DatabaseHelper.instance.prescList("Symptoms", selectedId ?? 0).then(
      (value) {
        setState(() {
          value.forEach((element) {
            print(element);
            prescList.add(
              PrescriptionModel(
                Symptom: element["Symptom"],
                DoctorName: element["DoctorName"],
                HospitalName: element["HospitalName"],
                DateOfAppointment: element["DateOfAppointment"],
                ReasonForAppointment: element["ReasonForAppointment"],
              ),
            );
            print(prescList.length);
          });
        });
      },
    );
  } */
  /* DatabaseHelper.instance.queryAllRows("Symptoms").then((value) {
      setState(() {
        value.forEach((element) {
          prescList.add(
            PrescriptionModel(
              Symptom: element["Symptom"],
              DoctorName: element["DoctorName"],
              HospitalName: element["HospitalName"],
              DateOfAppointment: element["DateOfAppointment"],
              ReasonForAppointment: element["ReasonForAppointment"],
            ),
          );
        });
      });
    }).catchError((error) {
      print(error);
    }); */

  /* getId(String name) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.userId(DatabaseHelper.table, name);
    print("data saved ${saved}");
    selectedId = saved;
    print('Id selected is $selectedId');
  } */

