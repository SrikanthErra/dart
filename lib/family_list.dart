import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/database_helper.dart';
import 'package:side_menu/modelClasses/family_list_model.dart';
import 'package:side_menu/modelClasses/prescription_list_model.dart';

import 'Reusable/app_input_text.dart';

class familyList extends StatefulWidget {
  const familyList({super.key});

  @override
  State<familyList> createState() => _familyListState();
}

class _familyListState extends State<familyList> {
  List<familyListModel> famList = [];
  String? FamilyMemeber = "";
  String? PrescriptionCount = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prescription List'), centerTitle: true),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppInputText(
                text: 'Family List',
                colors: Colors.black,
                size: 15,
                weight: FontWeight.bold),
            ListView.builder(
              shrinkWrap: true,
              itemCount: famList.length,
              itemBuilder: (context, index) {
                final familylist = famList[index];
                print(familylist);
                FamilyMemeber = familylist.Name;
                print(FamilyMemeber);
                PrescriptionCount = familylist.Count;
                return Container(
                  child: Card(
                    // margin: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.prescriptionList);
                      },
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppInputText(
                                text: 'Name of Family Member',
                                colors: Colors.black,
                                size: 14,
                                weight: FontWeight.normal),
                          ),
                          Expanded(
                            child: AppInputText(
                                text: 'Prescription Count',
                                colors: Colors.black,
                                size: 14,
                                weight: FontWeight.normal),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: AppInputText(
                                text: FamilyMemeber ?? "",
                                //text: familylist.nameOfFamilyMember ?? "",
                                colors: Colors.black,
                                size: 14,
                                weight: FontWeight.normal),
                          ),
                          // Expanded(
                          //   child: AppInputText(
                          //       text: PrescriptionCount ?? "",
                          //       colors: Colors.black,
                          //       size: 14,
                          //       weight: FontWeight.normal),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        )),
      ),
    );
  }

  void initState() {
    super.initState();
    fetchNextVisitData();
  }

  fetchNextVisitData() async {
    DatabaseHelper _dbInstance = DatabaseHelper.instance;
    await _dbInstance.queryAllRows('FamilyList').then((value) {
      setState(() {
        value.forEach((element) {
          famList.add(familyListModel(Name: element['name']));
          //print('getdetails${famList}');
        });
      });
      print('getdetails${famList}');
    });
  }
}
