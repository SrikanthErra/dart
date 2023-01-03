import 'package:side_menu/FamilyList/total_presc_view.dart';
import 'package:side_menu/Login/registration.dart';
import 'package:side_menu/autocomplete_dropdown.dart';
import 'package:side_menu/view_Medicine/view_medicine.dart';

class AppRoutes {
  AppRoutes._();
  static const initial = login;
  static const autocomplete = "/autocomplete";
  static const SideMenu = "/SideMenu";
  static const totalPrescView = "/totalPrescView";
  static const combinedDropdown = "/combinedDropdown";
  static const MultiselectDropdown = "/MultiselectDropdown";
  static const familyList = "/familyList";
  static const prescriptionList = "/prescriptionList";
  static const addPrescription = "/addPrescription";
  static const otp = "/otp";
  static const pdfViewer = "/pdfViewer";
  static const viewPrescription = "/viewPrescription";
  static const mpinPage = "/mpinPage";
  static const mpinValidate = "/mpinValidate";
  static const login = "/login";
  static const visitAlerts = "/visitAlerts";
  static const registraion = "/registraion";
  static const dashboardGridview = "/dashboardGridview";
  static const registerFamilyDashboard = "/registerFamily";
  static const MedicineListView = "/medicineView";
  static const viewMedicine = "/viewMedicine";
  static const viewReports = "/reports.dart";
  static const viewAllMedicines = "/allMedicinesView.dart";
  static const viewPrivacyPolicy = "/privacypolicy.dart";
  static const viewProfile = "/viewProfile.dart";
}
