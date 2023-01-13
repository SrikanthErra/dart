import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/Constants/TextStyles.dart';
import 'package:medicineinventory/Constants/assetsPath.dart';
import 'package:medicineinventory/Reusable/app_input_text.dart';
import '../CustomAlerts/WarningAlert.dart';
import 'package:medicineinventory/modelClasses/nextVisit_model.dart';
import 'package:medicineinventory/modelClasses/next_visit._model.dart';
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
  List<NextVisitModel> nextvisitList = [];
  List<MedicineModel> expiryList = [];
  String? hospitalName;
  String? nextvisitdate;
  String? reason;
  String? _expiryMedicineName;
  String? _expiryDate;
  Widget build(BuildContext context) {
    /* print('len is ${nextvisitList[0].HospitalName}');
    print(nextvisitList[0].HospitalName == ''); */
    EasyLoading.dismiss();
    return new WillPopScope(
      onWillPop: () async {
        await EasyLoading.show(
            status: strings.Loader, maskType: EasyLoadingMaskType.black);
        Navigator.pushNamed(context, AppRoutes.dashboardGridview);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(strings.AlertTitle),
          centerTitle: true,
          leading: IconButton(
              onPressed: () async {
                await EasyLoading.show(
                    status: strings.Loader,
                    maskType: EasyLoadingMaskType.black);
                Navigator.pushNamed(context, AppRoutes.dashboardGridview);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetPath.Background),
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
                    text: strings.Alert_NextVisit,
                    colors: Colors.white,
                    size: 15,
                    weight: FontWeight.bold),
                /* (hospitalName == '' && nextvisitdate == '' && reason == '')
                      ? Container()
                      :  */
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
                                strings.Presc_Hint_hospName,
                                hospitalName,
                              ),
                              RowComponent(
                                strings.Alert_NextVistDate,
                                nextvisitdate,
                              ),
                              RowComponent(
                                strings.Presc_Hint_AppointmentReason,
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
                    text: strings.Alert_Expiry,
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
                    DateFormat dateFormat = DateFormat(strings.dateFormat);
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              strings.Alert_ExpiryTitle,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          AnimatedBuilder(
                                              animation: animation,
                                              builder: (BuildContext context,
                                                  Widget? child) {
                                                return IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return WarningAlert(
                                                          title:
                                                              'Remove Medicine from the Inventory',
                                                          descriptions:
                                                              'Do you want to delete "${expirylist.MedicineName}" Medicine from the table?',
                                                          img: Image.asset(AssetPath
                                                              .WarningBlueIcon),
                                                          Buttontext2:
                                                              strings.Alerts_No,
                                                          onButton2Pressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          Buttontext1: strings
                                                              .Alerts_Yes,
                                                          onButton1Pressed:
                                                              () async {
                                                            DatabaseHelper
                                                                .instance
                                                                .delete(expirylist
                                                                    .MedicineId!);
                                                            await EasyLoading.show(
                                                                status: strings
                                                                    .Loader,
                                                                maskType:
                                                                    EasyLoadingMaskType
                                                                        .black);
                                                            Navigator
                                                                .pushReplacementNamed(
                                                                    context,
                                                                    AppRoutes
                                                                        .visitAlerts);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red),
                                                  iconSize: 22,
                                                );
                                              }),
                                        ],
                                      ),
                                      RowComponent(
                                        strings.Med_MedName,
                                        expirylist.MedicineName,
                                      ),
                                      RowComponent(
                                        strings.Med_ExpDate,
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
                                      strings.Med_MedName,
                                      _expiryMedicineName,
                                    ),
                                    RowComponent(
                                      strings.Med_ExpDate,
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
    DatabaseHelper.instance.nextVisit().then((value) {
      setState(() {
        value.forEach((element) {
          print('element is $element');
          print('hell ${element["HospitalName"]}');
          print('hell ${element["NextAppointmentDate"]}');
          print('hell ${element["ReasonForAppointment"]}');
          final hospName = element["HospitalName"];
          final nxt = element['NextAppointmentDate'];
          final reason = element['ReasonForAppointment'];
          if (hospName.toString() != '' &&
              nxt.toString() != '' &&
              reason.toString() != '') {
            print('jhcvsajdvas');
            nextvisitList.add(NextVisitModel(
              HospitalName: element["HospitalName"],
              NextAppointmentDate: element["NextAppointmentDate"],
              ReasonForAppointment: element["ReasonForAppointment"],
            ));
          } else {
            print('entered in else');
          }
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
        DateFormat dateFormat = DateFormat(strings.dateFormat);
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
