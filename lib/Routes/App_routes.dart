import 'package:side_menu/add_prescription.dart';
import 'package:side_menu/dashboard.dart';
import 'package:side_menu/family_list.dart';
import 'package:side_menu/mpin.dart';
import 'package:side_menu/prescription_list.dart';
import 'package:side_menu/prescription_view.dart';
import 'package:side_menu/side_menu.dart';
import 'package:side_menu/visit_alerts.dart';

class AppRoutes {
  AppRoutes._();
  static const initial = login;
  static const SideMenu = "/SideMenu";
  static const familyList = "/familyList";
  static const prescriptionList = "/prescriptionList";
  static const addPrescription = "/addPrescription";
  static const otp = "/otp";
   static const viewPrescription = "/viewPrescription";
  static const mpinPage = "/mpinPage";
  static const mpinValidate = "/mpinValidate";
  static const login = "/login";
  static const visitAlerts = "/visitAlerts";
  static const registraion = "/registraion";
  static const dashboard = "/dashboard";
}

