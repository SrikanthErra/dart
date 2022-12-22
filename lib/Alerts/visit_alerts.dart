import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/notifier/alert_count_notifier.dart';
import '../Database/database_helper.dart';
import '../Routes/App_routes.dart';
import '../modelClasses/database_modelClass/PrescriptionModel.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';

class visitAlerts extends StatefulWidget {
  const visitAlerts({super.key});

  @override
  State<visitAlerts> createState() => _visitAlertsState();
}

class _visitAlertsState extends State<visitAlerts>
    with SingleTickerProviderStateMixin {
  int count = 0;
  late Animation<Color?> animation;
  late AnimationController controller;
  List<PrescriptionModel> nextvisitList = [];
  List<MedicineModel> expiryList = [];
  String? hospitalName;
  String? nextvisitdate;
  String? reason;
  String? _expiryMedicineName;
  String? _expiryDate;
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return new WillPopScope(
      onWillPop: () async {
        await EasyLoading.show(
            status: "Loading...", maskType: EasyLoadingMaskType.black);
        Navigator.pushNamed(context, AppRoutes.dashboardGridview);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Alerts'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () async {
                await EasyLoading.show(
                    status: "Loading...", maskType: EasyLoadingMaskType.black);
                Navigator.pushNamed(context, AppRoutes.dashboardGridview);
              },
              icon: Icon(Icons.arrow_back)),
        ),
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
                    nextvisitdate = nextvisit.NextAppointmentDate;
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
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: expiryList.length,
                  itemBuilder: (context, index) {
                    final expirylist = expiryList[index];
                    _expiryMedicineName = expirylist.MedicineName;
                    _expiryDate = expirylist.ExpiryDate;
                    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
                    final Exp = dateFormat.parse(_expiryDate!);
                    return ((Exp).isBefore(DateTime.now()))
                        ? AnimatedBuilder(
                            animation: animation,
                            builder: (BuildContext context, Widget? child) {
                              return Card(
                                color: animation.value,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: Colors.black87, width: 1),
                                  ),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Expired Medicine",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          AnimatedBuilder(
                                              animation: animation,
                                              builder: (BuildContext context,
                                                  Widget? child) {
                                                return IconButton(
                                                  onPressed: () async {
                                                    DatabaseHelper.instance
                                                        .delete(expirylist
                                                            .MedicineId!);
                                                    await EasyLoading.show(
                                                        status: "Loading...",
                                                        maskType:
                                                            EasyLoadingMaskType
                                                                .black);
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context,
                                                            AppRoutes
                                                                .visitAlerts);
                                                  },
                                                  icon: Icon(Icons.delete,
                                                      color: Colors.red),
                                                  iconSize: 14,
                                                );
                                              }),
                                        ],
                                      ),
                                      RowComponent(
                                        "Medicine Name",
                                        expirylist.MedicineName,
                                      ),
                                      RowComponent(
                                        "Expiry Date",
                                        expirylist.ExpiryDate,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
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
                                      "Medicine Name",
                                      _expiryMedicineName,
                                    ),
                                    RowComponent(
                                      "Expiry Date",
                                      expirylist.ExpiryDate,
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
      ),
    );
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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

  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    animation =
        ColorTween(begin: Colors.red, end: Colors.purple).animate(curve);
    // Keep the animation going forever once it is started
    animation.addStatusListener((status) {
      // Reverse the animation after it has been completed
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
    // Remove this line if you want to start the animation later
    controller.forward();
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
              NextAppointmentDate: element['NextAppointmentDate'],
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
              MedicineId: element["MedicineId"],
              MedicineName: element["MedicineName"],
              ExpiryDate: element["ExpiryDate"],
            ),
          );
        });
      });
      expiryList.forEach((element) {
        final expiry = element.ExpiryDate;
        DateFormat dateFormat = DateFormat("dd-MM-yyyy");
        final Exp = dateFormat.parse(expiry!);
        if (Exp.isBefore(DateTime.now())) {
          count++;
        }
      });
      print(count);
    }).catchError((error) {
      print(error);
    });
    /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final CountProvider =
          Provider.of<AlertsCountProvider>(context, listen: false);
      countAlerts(CountProvider);
    }); */
  }

  /* void countAlerts(AlertsCountProvider countProvider) {
    expiryList.forEach((element) {
      final Expiry = element.ExpiryDate;
      DateFormat dateFormat = DateFormat("dd-MM-yyyy");
      final Exp = dateFormat.parse(Expiry!);
      print(Exp);
      if ((Exp).isBefore(DateTime.now())) {
        final CounterAlert = countProvider.CountIncrementer();
        print(CounterAlert);
      }
    });
  } */

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
