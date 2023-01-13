import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/Constants/TextStyles.dart';
import 'package:medicineinventory/Constants/assetsPath.dart';
import '../Database/database_helper.dart';
import '../modelClasses/registration_familyList_model.dart';
import '../notifier/mobile_notifier.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  List<registrationFamilyModel> profile = [];
  @override
  Widget build(BuildContext context) {
    String mobile_number = Provider.of<MobileProvider>(context).getMobile;
    fetchAllData(mobile_number);
    return Scaffold(
      appBar: AppBar(title: Text(strings.ProfileTitle), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.Background),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: profile.length,
                itemBuilder: (context, index) {
                  final profileDetails = profile[index];
                  final MemberName = profileDetails.name;
                  final MemberGender = profileDetails.gender;
                  final MemberAge = profileDetails.age;
                  final MemberMobile = profileDetails.mobile;
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 40),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black87, width: 1),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          children: [
                            RowComponent(strings.Profile_FamName, MemberName),
                            RowComponent(
                                strings.Profile_FamGender, MemberGender),
                            RowComponent(strings.Profile_FamAge, MemberAge),
                            RowComponent(
                                strings.Profile_FamMobile, MemberMobile),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.toString(),
              style: RowComponentHeaderTextStyle,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: RowComponentTextStyle,
            ),
          )
        ],
      ),
    );
  }

  fetchAllData(String mobile_number) async {
    await DatabaseHelper.instance
        .queryLogin(DatabaseHelper.table, mobile_number)
        .then((value) {
      setState(() {
        profile = [];
        value.forEach((element) {
          profile.add(registrationFamilyModel(
            name: element['name'],
            age: element['age'],
            gender: element['gender'],
            mobile: element['mobileNumber'],
          ));
        });
      });
    });
  }
}
