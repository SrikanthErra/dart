import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/modelClasses/family_list_names_provider.dart';
import 'package:medicineinventory/modelClasses/prescription_list_provider.dart';
import 'Routes/App_pages.dart';
import 'Routes/App_routes.dart';
import 'Constants/appColor.dart';
import 'modelClasses/medicine_list_provider.dart';
import 'notifier/alert_count_notifier.dart';
import 'notifier/mobile_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          ChangeNotifierProvider(create: (_) => PrescriptionListProvider()),
          ChangeNotifierProvider(create: (_) => AlertsCountProvider()),
          ChangeNotifierProvider(create: (_) => MobileProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: strings.AppTitle,
          initialRoute: AppRoutes.initial,
          routes: AppPages.routes,
          theme: ThemeData(
            primarySwatch: AppColors.navy,
          ),
          //home: SideMenu(),
          builder: EasyLoading.init(),
        ));
  }
}
