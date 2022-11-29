import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:side_menu/navigation_bar.dart';

import 'dashboard.dart';

class SideMenu extends StatelessWidget {
  SideMenu({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> emp = ['Srikanth', '22', 'Teju', '16', 'Kasai', '40'];
  //final List<DashboardList> dashbordList = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Nav_Bar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/bg.png'),
        )),
        child: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/bg.png'),
                  )),
                  child: IconButton(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          //child: Image(image: AssetImage('assets/pqms.jpeg'),height: 50,width: 200,),
                          child: Image.asset('assets/pqms.jpeg',
                              width: 150, height: 50, fit: BoxFit.fill),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Hello Srikanth',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Hello Teja',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            'Hello Kasai',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: emp.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: Border.all(color: Colors.black),
                  color: Colors.transparent,
                  //shadowColor: Colors.transparent,
                   
                  child: ListTile(
                    title: Text(emp[index],style: TextStyle(color: Colors.white),),
                  ),
                );
              },
            ),
          ),
              ),
              ]),
        ),
      
    ));
    
  }
}
