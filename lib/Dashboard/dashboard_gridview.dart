import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:side_menu/CustomAlerts/WarningAlert.dart';
import 'package:side_menu/Dashboard/sidemenuDashboard.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/Constants/appColor.dart';
import '../Constants/StringConstants.dart';
import '../Constants/assetsPath.dart';
import '../Database/database_helper.dart';
import '../modelClasses/dashboard_gridview_model.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';

class dashboardGridview extends StatefulWidget {
  const dashboardGridview({super.key});

  @override
  State<dashboardGridview> createState() => _dashboardGridviewState();
}

class _dashboardGridviewState extends State<dashboardGridview>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;
  int counter = 0;
  List<MedicineModel> expiryList = [];
  List<gridListView> dashboardList = [
    gridListView(
        image: Image.asset(
          AssetPath.addMemberIcon,
          fit: BoxFit.fitWidth,
          height: 60,
          width: 60,
          color: Colors.white,
        ),
        title: strings.DashBoard_AddMember,
        navigateApproute: AppRoutes.registerFamilyDashboard),
    gridListView(
        image: Image.asset(
          AssetPath.familyListIcon,
          fit: BoxFit.fitWidth,
          height: 60,
          width: 60,
          color: Colors.white,
        ),
        title: strings.DashBoard_FamList,
        navigateApproute: AppRoutes.familyList),
    gridListView(
      image: Image.asset(
        AssetPath.reportsIcon,
        fit: BoxFit.fitWidth,
        height: 60,
        width: 60,
        color: Colors.white,
      ),
      title: strings.DashBoard_Reports,
      navigateApproute: AppRoutes.viewReports,
    ),
    gridListView(
        image: Image.asset(
          AssetPath.alertsIcon,
          fit: BoxFit.fitWidth,
          height: 60,
          width: 60,
          color: Colors.white,
        ),
        title: strings.DashBoard_Alerts,
        navigateApproute: AppRoutes.visitAlerts),
    gridListView(
        image: Image.asset(
          AssetPath.addPrescriptionIcon,
          fit: BoxFit.fitWidth,
          height: 60,
          width: 60,
          color: Colors.white,
        ),
        title: strings.DashBoard_AddMed,
        navigateApproute: AppRoutes.addPrescription),
    gridListView(
        image: Image.asset(
          AssetPath.viewMedicineIcon,
          fit: BoxFit.fitWidth,
          height: 60,
          width: 60,
          color: Colors.white,
        ),
        title: strings.DashBoard_ViewMed,
        navigateApproute: AppRoutes.viewMedicine),
  ];

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: SidemenuDashboard(),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(strings.Dashboard),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetPath.Background),
              fit: BoxFit.cover,
            ),
          ),
          // margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: AppInputText(
                    text: strings.Dashboard,
                    colors: Colors.white,
                    size: 30,
                    weight: FontWeight.w400),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  itemCount: dashboardList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 1),
                  itemBuilder: (context, index) {
                    final dashboardData = dashboardList[index];
                    return (dashboardData.title == strings.DashBoard_Alerts)
                        ? GestureDetector(
                            onTap: () async {
                              await EasyLoading.show(
                                  status: strings.Loader,
                                  maskType: EasyLoadingMaskType.black);
                              Navigator.pushNamed(context,
                                  dashboardData.navigateApproute ?? "");
                            },
                            child: Card(
                              color: AppColors.navy.withOpacity(0.1),
                              child: counter != 0
                                  ? Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: dashboardData.image!,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  dashboardData.title ?? "",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  AnimatedBuilder(
                                                    animation: animation,
                                                    builder:
                                                        (BuildContext context,
                                                            Widget? child) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          decoration:
                                                              new BoxDecoration(
                                                            color:
                                                                animation.value,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Text(
                                                            '$counter',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: dashboardData.image!,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            //padding: EdgeInsets.all(5),
                                            child: Text(
                                              dashboardData.title ?? "",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await EasyLoading.show(
                                  status: strings.Loader,
                                  maskType: EasyLoadingMaskType.black);
                              Navigator.pushNamed(context,
                                  dashboardData.navigateApproute ?? "");
                            },
                            child: Card(
                              color: AppColors.navy.withOpacity(0.1),
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Material(
                                          //borderOnForeground: false,
                                          color: Colors.transparent,
                                          //shape: CircleBorder(),
                                          //elevation: 3.0,
                                          child: dashboardData.image),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        //padding: EdgeInsets.all(5),
                                        child: Text(
                                          dashboardData.title ?? "",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                  }),
            ],
          ),
        ),
        bottomSheet: Image.asset(
          AssetPath.footer,
          width: double.infinity,
          height: 40,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
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
    DatabaseHelper.instance.queryAllRows(DatabaseHelper.table3).then((value) {
      setState(() {
        value.forEach((element) {
          expiryList.add(
            MedicineModel(
              ExpiryDate: element["ExpiryDate"],
            ),
          );
        });
      });
      setState(() {
        expiryList.forEach((element) {
          final expiry = element.ExpiryDate;
          DateFormat dateFormat = DateFormat(strings.dateFormat);
          final Exp = dateFormat.parse(expiry!);
          if (Exp.isBefore(DateTime.now())) {
            counter++;
          }
        });
        print(counter);
      });
    }).catchError((error) {
      print(error);
    });
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
            context: context,
            builder: (context) => WarningAlert(
                title: strings.AppTitle,
                descriptions:
                    strings.Alerts_titleAreYouSure + strings.Alerts_ExitApp,
                Buttontext2: strings.Alerts_No,
                Buttontext1: strings.Alerts_Yes,
                img: Image.asset(AssetPath.WarningBlueIcon),
                onButton2Pressed: () {
                  Navigator.of(context).pop(false);
                },
                onButton1Pressed: () {
                  SystemNavigator.pop();
                })) ??
        false;
  }
}
