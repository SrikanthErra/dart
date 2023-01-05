import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:side_menu/Constants/assetsPath.dart';
import '../Constants/StringConstants.dart';
import '../Routes/App_routes.dart';

class SidemenuDashboard extends StatefulWidget {
  const SidemenuDashboard({super.key});

  @override
  State<SidemenuDashboard> createState() => _SidemenuDashboardState();
}

class _SidemenuDashboardState extends State<SidemenuDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        //backgroundColor: Colors.blue.withOpacity(0.5),
        child: ListView(
          children: [
            Container(
              child: DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                        height: 80,
                        width: 80,
                        image: AssetImage(AssetPath.AppLogo)),
                    Text(
                      strings.Sidemenu_welcome,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      strings.AppTitle,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        'Version 2.8',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ), */
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AssetPath.Background),
                )),
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.Sidemenu_Home,
                      style: TextStyle(color: Colors.grey.shade700)),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(strings.Dashboard),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.dashboardGridview);
                    },
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      strings.Sidemenu_Services,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  ListTile(
                    leading: ImageIcon(AssetImage(AssetPath.addMemberIcon)),
                    title: Text(strings.DashBoard_AddMember),
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.registerFamilyDashboard);
                    },
                  ),
                  ListTile(
                    leading: ImageIcon(AssetImage(AssetPath.familyListIcon)),
                    title: Text(strings.DashBoard_FamList),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.familyList);
                    },
                  ),
                  ListTile(
                    leading: ImageIcon(AssetImage(AssetPath.reportsIcon)),
                    title: Text(strings.DashBoard_Reports),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.viewReports);
                    },
                  ),
                  ListTile(
                    leading: ImageIcon(AssetImage(AssetPath.alertsIcon)),
                    title: Text(strings.DashBoard_Alerts),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.visitAlerts);
                    },
                  ),
                  ListTile(
                    leading: ImageIcon(
                      AssetImage(AssetPath.addPrescriptionIcon),
                    ),
                    title: Text(strings.DashBoard_AddMed),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.addPrescription);
                    },
                  ),
                  ListTile(
                    leading: ImageIcon(AssetImage(AssetPath.viewMedicineIcon)),
                    title: Text(strings.DashBoard_ViewMed),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.viewMedicine);
                    },
                  ),
                  ListTile(
                    leading: ImageIcon(AssetImage(AssetPath.reportsIcon)),
                    title: Text(strings.Sidemenu_InvMed),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.viewAllMedicines);
                    },
                  ),
                ],
              ),
            ),
            /* Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Advertisement',
                      style: TextStyle(color: Colors.grey.shade700)),
                  ListTile(
                    leading: Icon(Icons.window),
                    title: Text("Hoardings Info"),
                    onTap: () {},
                  ),
                ],
              ),
            ), */
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.Sidemenu_Others,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  /* ListTile(
                    leading: Icon(Icons.color_lens),
                    title: Text("Themes"),
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => hello()));
                    },
                  ), */
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text(strings.Sidemenu_Exit),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(strings.Alerts_exit),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => SystemNavigator.pop(),
                                    child: const Text(strings.Alerts_Yes),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(strings.Alerts_No),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_outlined),
                    title: Text(strings.Logout),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(strings.Alerts_logout),
                            /* content:
                                const Text('Do you want to logout from app'), */
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(
                                            context, AppRoutes.login),
                                    child: const Text(strings.Alerts_Yes),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(strings.Alerts_No),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.Sidemenu_info,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  ListTile(
                    leading: Icon(Icons.blur_linear_sharp),
                    title: Text(strings.Sidemenu_userManual),
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => hello()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.admin_panel_settings_outlined),
                    title: Text(strings.Sidemenu_privacyPolicy),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.viewPrivacyPolicy);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outlined),
                    title: Text(strings.Sidemenu_appInfo),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.AppInfo);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text(strings.Sidemenu_appRating),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.AppRating);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
