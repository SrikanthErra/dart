import 'package:flutter/material.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/container.dart';
import 'package:side_menu/Routes/App_routes.dart';

import 'Reusable/button_component.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
               containerComponent(containerText: 'Add Family Member', containercolors: Color.fromARGB(255, 33, 23, 170),
               textcolor: Colors.white, size: 20, weight: FontWeight.bold,
                textalign: TextAlign.center, routeName: AppRoutes.registraion,),
                containerComponent(containerText: 'Family List', containercolors: Color.fromARGB(255, 15, 150, 53),
               textcolor: Colors.white, size: 20, weight: FontWeight.bold,
                textalign: TextAlign.center, routeName: AppRoutes.familyList,),
                ],
              ),
              Row(
                children: [
               containerComponent(containerText: 'Reports', containercolors: Color.fromARGB(255, 219, 149, 20),
               textcolor: Colors.white, size: 20, weight: FontWeight.bold,
                textalign: TextAlign.center, routeName: AppRoutes.login,),
                containerComponent(containerText: 'Alerts', containercolors: Color.fromARGB(255, 241, 11, 141),
               textcolor: Colors.white, size: 20, weight: FontWeight.bold,
                textalign: TextAlign.center, routeName: AppRoutes.visitAlerts,),
                ],
              ),
              Row(
                children: [
               containerComponent(containerText: 'Add Medicine', containercolors: Color.fromARGB(255, 217, 55, 10),
               textcolor: Colors.white, size: 20, weight: FontWeight.bold,
                textalign: TextAlign.center, routeName: AppRoutes.addPrescription,),
                containerComponent(containerText: ' View Medicine', containercolors: Color.fromARGB(255, 223, 209, 13),
               textcolor: Colors.white, size: 20, weight: FontWeight.bold,
                textalign: TextAlign.center, routeName: AppRoutes.viewPrescription,),
                ],
              )
             
            ],
          ),
        ),
      ),
    );
  }
}
