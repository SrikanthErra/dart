import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/modelClasses/expiry_alertsModel.dart';
import 'package:side_menu/modelClasses/next_visit._model.dart';

class visitAlerts extends StatefulWidget {
  const visitAlerts({super.key});

  @override
  State<visitAlerts> createState() => _visitAlertsState();
}

class _visitAlertsState extends State<visitAlerts> {
  List<nextVisitModel> nextvisitList = [];
  List<expiryAlertModel> expiryList = [];
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppInputText(
                      text: 'Next Visit Alerts',
                      colors: Colors.white,
                      size: 15,
                      weight: FontWeight.bold),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: nextvisitList.length,
                    itemBuilder: (context, index) {
                      final nextvisit = nextvisitList[index];
                      hospitalName = nextvisit.hospitalName;
                      nextvisitdate = nextvisit.nextVisitDate;
                      reason = nextvisit.reason;

                      return Container(
                        height: 80,
                        child: Card(
                          // margin: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AppInputText(
                                      text: 'Hospital Name',
                                      colors: Colors.black,
                                      size: 14,
                                      weight: FontWeight.normal),
                                ),
                                Expanded(
                                  child: AppInputText(
                                      text: 'Next appointment date',
                                      colors: Colors.black,
                                      size: 14,
                                      weight: FontWeight.normal),
                                ),
                                Expanded(
                                  child: AppInputText(
                                      text: 'Reason',
                                      colors: Colors.black,
                                      size: 14,
                                      weight: FontWeight.normal),
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: AppInputText(
                                      text: hospitalName ?? "",
                                      colors: Colors.black,
                                      size: 14,
                                      weight: FontWeight.normal),
                                ),
                                Expanded(
                                  child: AppInputText(
                                      text: nextvisitdate ?? "",
                                      colors: Colors.black,
                                      size: 14,
                                      weight: FontWeight.normal),
                                ),
                                Expanded(
                                  child: AppInputText(
                                      text: reason ?? "",
                                      colors: Colors.black,
                                      size: 14,
                                      weight: FontWeight.normal),
                                )
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
                      _expiryMedicineName = expirylist.medicalName;
                      _expiryDate = expirylist.expiryDate;

                      print("the name is $hospitalName");
                      return Container(
                        //height: 60,
                        child: Card(
                          // margin: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AppInputText(
                                      text: 'Medicine Name',
                                      colors: Colors.black,
                                      size: 18,
                                      weight: FontWeight.normal),
                                ),
                                Expanded(
                                  child: AppInputText(
                                      text: 'Expiry date',
                                      colors: Colors.black,
                                      size: 14,
                                      weight: FontWeight.normal),
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: AppInputText(
                                      text: _expiryMedicineName ?? "",
                                      colors: Colors.black,
                                      size: 14,
                                      weight: FontWeight.normal),
                                ),
                                Expanded(
                                  child: AppInputText(
                                      text: _expiryDate ?? "",
                                      colors: Colors.black,
                                      size: 14,
                                      weight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            )));
  }

  void initState() {
    super.initState();
    fetchNextVisitData();
  }

  fetchNextVisitData() {
    nextvisitList = [
      nextVisitModel(
          hospitalName: "VPsycho Hospital",
          nextVisitDate: "30/12/2022",
          reason: 'Sugar'),
      nextVisitModel(
          hospitalName: "VPsycho Hospital",
          nextVisitDate: "30/12/2022",
          reason: 'Sugar'),
    ];
    expiryList = [
      expiryAlertModel(medicalName: "Para", expiryDate: "21/3/2025"),
      expiryAlertModel(medicalName: "cipla", expiryDate: "31/1/2030"),
      expiryAlertModel(medicalName: "fascf", expiryDate: "23/3/2025"),
    ];
  }
}
