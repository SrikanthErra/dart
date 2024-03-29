import 'package:flutter/material.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/Constants/assetsPath.dart';
import 'package:medicineinventory/Routes/App_routes.dart';
import 'package:medicineinventory/Constants/app_constants.dart';
import '../Constants/appColor.dart';
import '../CustomAlerts/customAlerts.dart';
import '../Database/database_helper.dart';
import '../Reusable/alert.dart';
import '../Reusable/app_input_text.dart';
import '../modelClasses/database_modelClass/PrescriptionModel.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';
import '../modelClasses/total_presc_view_model.dart';
import '../modelClasses/family_list_model.dart';
import 'family_list.dart';

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
  String? FamilyMemberName;
  List<PrescriptionModel> prescList = [];

  List<PrescriptionModel> viewSymptomList = [];
  List<PrescriptionModel> viewSearchSymptomList = [];

  List<totalPrescViewModel> totalPresc = [];
  List<MedicineModel> MedList = [];
  List<familyListModel> famList = [];
  int? famID;
  @override
  Widget build(BuildContext context) {
    FamilyArguments argument =
        ModalRoute.of(context)?.settings.arguments as dynamic;
    prescList = argument.prescList;
    FamilyMemberName = argument.name;
    famID = argument.id;
    print('list ${prescList[0].Symptom}');
    print('namefam $FamilyMemberName');
    print('famid $famID');
    return Scaffold(
      appBar: AppBar(title: Text(strings.familyList_Title), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.Background),
            fit: BoxFit.cover,
          ),
        ),
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
                      text: "${FamilyMemberName}'s Prescriptions",
                      colors: Colors.white,
                      size: 15,
                      weight: FontWeight.bold,
                    ),
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
                          labelText: strings.SearchSymptom,
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
                      itemCount: viewSearchSymptomList.length,
                      itemBuilder: (context, index) {
                        final prescriptionlist = viewSearchSymptomList[index];
                        DoctorName = prescriptionlist.DoctorName;
                        PrescriptionDate = prescriptionlist.DateOfAppointment;
                        Symptoms = prescriptionlist.Symptom;
                        symptomId = prescriptionlist.SymptomId;
                        return Container(
                          child: GestureDetector(
                            onTap: () {
                              print(
                                  'symptom id is ${prescriptionlist.SymptomId}');
                              print('sid is ${prescriptionlist.SId}');
                              // fetchdata(prescriptionlist.SId ?? 0);
                              Navigator.pushNamed(
                                  context, AppRoutes.MedicineListView,
                                  arguments: prescriptionlist.SId);
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              strings.Presc_Hint_DrName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          Expanded(
                                            child: Text(
                                              DoctorName ?? '',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              print(
                                                  'Famid  ${AppConstants.famMemId}');
                                              print(
                                                  'sid  ${prescriptionlist.SId}');
                                              fetchAllPresData(
                                                  AppConstants.famMemId ?? 0,
                                                  prescriptionlist.SId ?? 0);
                                              /*  Navigator.pushNamed(context,
                                                AppRoutes.totalPrescView); */
                                            },
                                            iconSize: 20,
                                            icon: Icon(
                                                Icons.remove_red_eye_outlined),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RowComponent(
                                      strings.Prescription_Date,
                                      PrescriptionDate,
                                    ),
                                    RowComponent(strings.Symptoms, Symptoms)
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

  RowComponent(var data, var value, [var icon]) {
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
            width: 30,
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  /* fetchdata(int id) async {
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
          print(' id ${id}');
        });
        if (id != 0) {
          print('list od med is $MedList');
          Navigator.pushNamed(context, AppRoutes.MedicineListView,
              arguments: MedList);
        }
      });
    });
  } */

  fetchAllPresData(int id, int sid) async {
    await DatabaseHelper.instance.viewTotalPres(id, sid).then((value) {
      setState(() {
        totalPresc = [];
        print(value.length);

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
        if (totalPresc.length != 0) {
          Navigator.pushNamed(context, AppRoutes.totalPrescView,
              arguments: totalPresc
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
                    img: Image.asset(AssetPath.AppLogo),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    bgColor: AppColors.navy);
              });
        }
        // print(totalPresc[0].name);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      fetchSymptomdata(prescList);
    });
    

  }

  fetchSymptomdata(var list) async {
    setState(() {
      viewSymptomList = list;
      print('sym ${viewSymptomList}');

      /* prescList.forEach((element) {
        viewSymptomList.add(PrescriptionModel(
          Symptom: element.Symptom,
          DoctorName: element.DoctorName,
          DateOfAppointment: element.DateOfAppointment,
          FamilyMemberId: element.FamilyMemberId,
          SId: element.SId,
          SymptomId: element.SymptomId,
        ));
        print(' id ${viewSymptomList}');
        
      }); */
      viewSearchSymptomList = viewSymptomList;
        print('search ${viewSearchSymptomList}');
    });
   /*  await DatabaseHelper.instance.prescList('Prescription', id).then((value) {
      setState(() {
        viewSymptomList = [];
        value.forEach((element) {
          print('element is $element');
          viewSymptomList.add(PrescriptionModel(
            Symptom: element["Symptom"],
            DoctorName: element["DoctorName"],
            DateOfAppointment: element["DateOfAppointment"],
            FamilyMemberId: element["FamilyMemberId"],
            SId: element["SId"],
            SymptomId: element["SymptomId"],
          ));
          print('one id ${viewSymptomList}');
          viewSearchSymptomList = viewSymptomList;
          print('search ${viewSearchSymptomList}');
        });
      });
    }); */
  }

  _runFilter(String enteredKeyword) {
    List<PrescriptionModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = viewSymptomList;
    } else {
      print(enteredKeyword);
      results = viewSymptomList
          .where((element) => element.Symptom!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      viewSearchSymptomList = results;
      print('len ${viewSearchSymptomList.length}');
    });
  }
}
