import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:side_menu/Routes/App_routes.dart';

import 'dashboard_gridview_model.dart';

class dashboardGridview extends StatefulWidget {
  const dashboardGridview({super.key});

  @override
  State<dashboardGridview> createState() => _dashboardGridviewState();
}

class _dashboardGridviewState extends State<dashboardGridview> {
  List<gridListView> dashboardList = [
    gridListView(
        color: Colors.amber,
        title: 'Add Family Member',
        navigateApproute: AppRoutes.prescriptionList),
    gridListView(
        color: Colors.blue,
        title: ' Family List',
        navigateApproute: AppRoutes.familyList),
    gridListView(
        color: Colors.green,
        title: 'Reports',
        navigateApproute: AppRoutes.prescriptionList),
    gridListView(
        color: Colors.grey,
        title: 'Alerts',
        navigateApproute: AppRoutes.viewPrescription),
    gridListView(
        color: Colors.redAccent,
        title: 'Add Medicine',
        navigateApproute: AppRoutes.addPrescription),
    gridListView(
        color: Colors.purple,
        title: 'View Medicine',
        navigateApproute: AppRoutes.viewPrescription),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          centerTitle: true,
        ),
        body: GridView.builder(
            itemCount: dashboardList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              final dashboardData = dashboardList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, dashboardData.navigateApproute ?? "");
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: dashboardData.color,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    dashboardData.title ?? "",
                  ),
                ),
              );
            }));
  }
}
