import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_menu/modelClasses/family_list_names_provider.dart';

import 'Routes/App_pages.dart';
import 'Routes/App_routes.dart';
import 'appColor.dart';
import 'modelClasses/medicine_list_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MedicineListProvider()),
        ChangeNotifierProvider(create: (_) => FamilyListNamesProvider()), 
      ],
    child:MaterialApp(
      title: 'Flutter Demo',
      initialRoute: AppRoutes.initial,
      routes: AppPages.routes,
      theme: ThemeData(
        primarySwatch: AppColors.navy,
      ),
      //home: SideMenu(),
    ));
  }
}
