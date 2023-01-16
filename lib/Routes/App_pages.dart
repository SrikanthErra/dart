import 'package:flutter/cupertino.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:medicineinventory/AddPrescription/add_prescription.dart';
import 'package:medicineinventory/AddPrescription/pdf_viewer.dart';
import 'package:medicineinventory/AppRating/appRating.dart';
import 'package:medicineinventory/Dashboard/allMedicinesView.dart';
import 'package:medicineinventory/Dashboard/appInfo.dart';
import 'package:medicineinventory/Dashboard/dashboard_gridview.dart';
import 'package:medicineinventory/Dashboard/userManual.dart';

import 'package:medicineinventory/FamilyList/reports.dart';
import 'package:medicineinventory/FamilyList/total_presc_view.dart';
import 'package:medicineinventory/Login/mpin.dart';
import 'package:medicineinventory/Login/mpin_validate.dart';
import 'package:medicineinventory/Login/otp.dart';
import 'package:medicineinventory/Login/registration.dart';
import 'package:medicineinventory/Login/resetMpin.dart';
import 'package:medicineinventory/autocomplete_dropdown.dart';
import 'package:medicineinventory/combined_dropdown.dart';
import 'package:medicineinventory/multi_select_dropdown.dart';
import 'package:medicineinventory/view_Medicine/prescription_view.dart';
import 'package:medicineinventory/view_Medicine/view_medicine.dart';

import '../Alerts/visit_alerts.dart';
import '../Dashboard/privacypolicy.dart';
import '../Dashboard/viewProfile.dart';
import '../FamilyList/family_list.dart';
import '../FamilyList/medicinesView.dart';
import '../FamilyList/prescription_list.dart';
import '../FamilyList/registerFamily.dart';
import '../Login/login.dart';
import 'App_routes.dart';
import '';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.mpinPage: ((context) => mpinPage()),
      AppRoutes.autocomplete: ((context) => autocomplete()),
      AppRoutes.totalPrescView: ((context) => totalPrescView()),
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
      AppRoutes.viewPrivacyPolicy: ((context) => privacyPolicy()),
      AppRoutes.viewProfile: ((context) => ViewProfile()),
      AppRoutes.AppInfo: ((context) => AppInfo()),
      AppRoutes.AppRating: ((context) => AppRating(
            rateMyApp: RateMyApp(),
          )),
      AppRoutes.UserManual: ((context) => UserManual()),
      AppRoutes.ResetMpin: ((context) => ResetMpin()),
    };
  }
}
