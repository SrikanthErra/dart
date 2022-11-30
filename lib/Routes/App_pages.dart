import 'package:flutter/cupertino.dart';
import 'package:side_menu/add_prescription.dart';

import 'package:side_menu/dashboard_gridview.dart';
import 'package:side_menu/family_list.dart';
import 'package:side_menu/login.dart';
import 'package:side_menu/mpin.dart';
import 'package:side_menu/mpin_validate.dart';
import 'package:side_menu/otp.dart';
import 'package:side_menu/prescription_list.dart';
import 'package:side_menu/prescription_view.dart';
import 'package:side_menu/registration.dart';
import 'package:side_menu/side_menu.dart';
import 'package:side_menu/visit_alerts.dart';

import 'App_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.SideMenu: ((context) => SideMenu()),
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
    };
  }
}
