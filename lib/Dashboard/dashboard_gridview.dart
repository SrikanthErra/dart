import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_menu/Dashboard/sidemenuDashboard.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/appColor.dart';
import '../modelClasses/dashboard_gridview_model.dart';

class dashboardGridview extends StatefulWidget {
  const dashboardGridview({super.key});

  @override
  State<dashboardGridview> createState() => _dashboardGridviewState();
}

class _dashboardGridviewState extends State<dashboardGridview> {
  int counter = 0;
  List<gridListView> dashboardList = [
    gridListView(
        image: Image.asset(
          "assets/icons-01.png",
          fit: BoxFit.fitWidth,
          height: 60,
          width: 60,
          color: Colors.white,
        ),
        title: 'Add Family Member',
        navigateApproute: AppRoutes.registerFamilyDashboard),
    gridListView(
        image: Image.asset(
          "assets/icons-06.png",
          fit: BoxFit.fitWidth,
          height: 60,
          width: 60,
          color: Colors.white,
        ),
        title: ' Family List',
        navigateApproute: AppRoutes.familyList),
    gridListView(
      image: Image.asset(
        "assets/icons-05.png",
        fit: BoxFit.fitWidth,
        height: 60,
        width: 60,
        color: Colors.white,
      ),
      title: 'Reports',
      navigateApproute: AppRoutes.viewReports,
    ),
    gridListView(
        image: Image.asset(
          "assets/icons-03.png",
          fit: BoxFit.fitWidth,
          height: 60,
          width: 60,
          color: Colors.white,
        ),
        title: 'Alerts',
        navigateApproute: AppRoutes.visitAlerts),
    gridListView(
        image: Image.asset(
          "assets/icons-02.png",
          fit: BoxFit.fitWidth,
          height: 60,
          width: 60,
          color: Colors.white,
        ),
        title: 'Add Medicine',
        navigateApproute: AppRoutes.addPrescription),
    gridListView(
        image: Image.asset(
          "assets/icons-04.png",
          fit: BoxFit.fitWidth,
          height: 60,
          width: 60,
          color: Colors.white,
        ),
        title: 'View Medicine',
        navigateApproute: AppRoutes.viewMedicine),
  ];

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: SidemenuDashboard(),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Dashboard'),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/dashboardBg.png"),
              fit: BoxFit.cover,
            ),
          ),
          // margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: AppInputText(
                    text: 'DASHBOARD',
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
                    return GestureDetector(
                      onTap: () async {
                        await EasyLoading.show(
                            status: "Loading...",
                            maskType: EasyLoadingMaskType.black);
                        Navigator.pushNamed(
                            context, dashboardData.navigateApproute ?? "");
                      },
                      child: Card(
                        color: AppColors.navy.withOpacity(0.1),
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
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
          "assets/footer.png",
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
    setState(() {});
  }
}
