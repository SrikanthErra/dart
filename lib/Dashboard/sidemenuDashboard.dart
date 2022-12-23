import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:side_menu/Reusable/alert.dart';
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
                        image: AssetImage("assets/appLogo.png")),
                    Text(
                      'Welcome to:',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'MEDICINE HOME INVENTORY',
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
                  image: AssetImage('assets/background_bg.png'),
                )),
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Profile',
                      style: TextStyle(color: Colors.grey.shade700)),
                  ListTile(
                    leading: Icon(Icons.person_pin_rounded),
                    title: Text("View Profile"),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.familyList);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text("Alerts"),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.visitAlerts);
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
                      'Services',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.grid_view_rounded),
                    title: Text("Medcinies"),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.viewAllMedicines);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.report),
                    title: Text("Abstract Report"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Card(
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
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Others',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  ListTile(
                    leading: Icon(Icons.color_lens),
                    title: Text("Themes"),
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => hello()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Exit"),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Do you want to Exit from app...?"),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => SystemNavigator.pop(),
                                    child: const Text('YES'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('NO'),
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
                    title: Text("Logout"),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Do you want to logout from app...?"),
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
                                    child: const Text('YES'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('NO'),
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
                    'Info',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  ListTile(
                    leading: Icon(Icons.blur_linear_sharp),
                    title: Text("User Manual"),
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => hello()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.admin_panel_settings_outlined),
                    title: Text("Privacy Policy"),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.viewPrivacyPolicy);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outlined),
                    title: Text("App Info"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text("App Rating"),
                    onTap: () {},
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
