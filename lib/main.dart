import 'package:flutter/material.dart';
import 'package:side_menu/side_menu.dart';

import 'Routes/App_pages.dart';
import 'Routes/App_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: AppRoutes.initial,
        routes: AppPages.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
      home: SideMenu(),
    );
  }
}
