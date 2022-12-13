import 'package:flutter/material.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import '../Database/database_helper.dart';
import '../modelClasses/database_modelClass/PrescriptionModel.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';

class visitAlerts extends StatefulWidget {
  const visitAlerts({super.key});

  @override
  State<visitAlerts> createState() => _visitAlertsState();
}

class _visitAlertsState extends State<visitAlerts> {
  List<PrescriptionModel> nextvisitList = [];
  List<MedicineModel> expiryList = [];
  String? hospitalName;
  String? nextvisitdate;
  String? reason;
  String? _expiryMedicineName;
  String? _expiryDate;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      //resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Alerts'), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        //margin: EdgeInsets.symmetric(vertical: 20),
        //  width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppInputText(
                  text: 'Next Visit Alerts',
                  colors: Colors.white,
                  size: 15,
                  weight: FontWeight.bold),
              ListView.builder(
               physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: nextvisitList.length,
                itemBuilder: (context, index) {
                  final nextvisit = nextvisitList[index];
                  hospitalName = nextvisit.HospitalName;
                  nextvisitdate = nextvisit.DateOfAppointment;
                  reason = nextvisit.ReasonForAppointment;
                  return Container(
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
                              "Hospital Name",
                              hospitalName,
                            ),
                            RowComponent(
                              "Next Visit Date",
                              nextvisitdate,
                            ),
                            RowComponent(
                              "Reason for Appointment",
                              reason,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              AppInputText(
                  text: 'Expiry Alerts',
                  colors: Colors.white,
                  size: 15,
                  weight: FontWeight.bold),
              ListView.builder(
                shrinkWrap: true,
                itemCount: expiryList.length,
                itemBuilder: (context, index) {
                  final expirylist = expiryList[index];
                  _expiryMedicineName = expirylist.MedicineName;
                  _expiryDate = expirylist.ExpiryDate;
                  print("the name is $hospitalName");
                  return Container(
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
                              "Medicine Name",
                              _expiryMedicineName,
                            ),
                            RowComponent(
                              "Expiry Date",
                              _expiryDate,
                            ),
                          ],
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
    DatabaseHelper.instance.queryAllRows("Symptoms").then((value) {
      setState(() {
        value.forEach((element) {
          nextvisitList.add(
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
    });
    DatabaseHelper.instance.queryAllRows("Medicines").then((value) {
      setState(() {
        value.forEach((element) {
          expiryList.add(
            MedicineModel(
              MedicineName: element["MedicineName"],
              ExpiryDate: element["ExpiryDate"],
            ),
          );
        });
      });
    }).catchError((error) {
      print(error);
    });
  }
}
