import 'package:flutter/material.dart';
//import 'package:side_menu/hello.dart';

class Nav_Bar extends StatelessWidget {
  const Nav_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            Container(
              child: DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Welcome to,',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        'Greater Hyderabad Muncipal',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        'Corporation',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        'Version 2.8',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/bg.png'),
                )),
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Profile',
                        style: TextStyle(color: Colors.grey.shade700)),
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text("Inbox"),
                    onTap: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => hello()));
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
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Services',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.grid_view_rounded),
                    title: Text("Grievances"),
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => hello()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.report),
                    title: Text("Abstract Report"),
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => hello()));
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
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Advertisement',
                        style: TextStyle(color: Colors.grey.shade700)),
                  ),
                  ListTile(
                    leading: Icon(Icons.window),
                    title: Text("Hoardings Info"),
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => hello()));
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
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Others',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
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
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Logout"),
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => hello()));
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
