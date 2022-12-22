import 'package:flutter/cupertino.dart';
import 'package:side_menu/AddPrescription/add_prescription.dart';
import 'package:side_menu/AddPrescription/pdf_viewer.dart';
import 'package:side_menu/Dashboard/allMedicinesView.dart';
import 'package:side_menu/Dashboard/dashboard_gridview.dart';
import 'package:side_menu/FamilyList/reports.dart';
import 'package:side_menu/Login/mpin.dart';
import 'package:side_menu/Login/mpin_validate.dart';
import 'package:side_menu/Login/otp.dart';
import 'package:side_menu/Login/registration.dart';
import 'package:side_menu/autocomplete_dropdown.dart';
import 'package:side_menu/combined_dropdown.dart';
import 'package:side_menu/multi_select_dropdown.dart';
import 'package:side_menu/view_Medicine/prescription_view.dart';
import 'package:side_menu/view_Medicine/view_medicine.dart';

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
      AppRoutes.autocomplete: ((context) => autocomplete()),
      AppRoutes.MultiselectDropdown: ((context) => MultiselectDropdown()),
      AppRoutes.combinedDropdown: ((context) => combinedDropdown()),
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
      AppRoutes.pdfViewer: ((context) => PdfViewer()),
      AppRoutes.registerFamilyDashboard: ((context) =>
          registerFamilyFromDashboard()),
      AppRoutes.MedicineListView: ((context) => MedicineList()),
      AppRoutes.viewMedicine: ((context) => viewMedicine()),
      AppRoutes.viewReports: ((context) => ReportsPage()),
      AppRoutes.viewAllMedicines: ((context) => AllMedicineList()),
    };
  }
}
