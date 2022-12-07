import 'package:flutter/cupertino.dart';
import 'package:side_menu/AddPrescription/add_prescription.dart';
import 'package:side_menu/Dashboard/dashboard_gridview.dart';
import 'package:side_menu/Login/mpin.dart';
import 'package:side_menu/Login/mpin_validate.dart';
import 'package:side_menu/Login/otp.dart';
import 'package:side_menu/Login/registration.dart';
import 'package:side_menu/PrescriptionView/prescription_view.dart';

import '../Alerts/visit_alerts.dart';
import '../FamilyList/family_list.dart';
import '../FamilyList/medicinesView.dart';
import '../FamilyList/prescription_list.dart';
import '../FamilyList/registerFamily.dart';
import '../Login/login.dart';
import 'App_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.mpinPage: ((context) => mpinPage()),
      AppRoutes.dashboardGridview: ((context) => dashboardGridview()),
      AppRoutes.familyList: ((context) => familyList()),
      AppRoutes.prescriptionList: ((context) => prescriptionList()),
      AppRoutes.viewPrescription: ((context) => viewPrescription()),
      AppRoutes.otp: ((context) => otp()),
      AppRoutes.addPrescription: ((context) => addPrescription()),
      AppRoutes.mpinValidate: ((context) => mpinValidate()),
      AppRoutes.login: ((context) => LoginPage()),
      AppRoutes.visitAlerts: ((context) => visitAlerts()),
      AppRoutes.registraion: ((context) => registerFamily()),
      AppRoutes.registerFamilyDashboard: ((context) =>
          registerFamilyFromDashboard()),
      AppRoutes.MedicineListView: ((context) => MedicineList()),
    };
  }
}
