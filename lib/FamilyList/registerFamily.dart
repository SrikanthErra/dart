import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_menu/Constants/StringConstants.dart';
import 'package:side_menu/Constants/assetsPath.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Reusable/toast.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/registration_familyList_model.dart';
import 'package:side_menu/Database/database_helper.dart';
import '../Constants/TextStyles.dart';
import '../CustomAlerts/customAlerts.dart';

class registerFamilyFromDashboard extends StatefulWidget {
  const registerFamilyFromDashboard({super.key});

  @override
  State<registerFamilyFromDashboard> createState() =>
      _registerFamilyFromDashboardState();
}

class _registerFamilyFromDashboardState
    extends State<registerFamilyFromDashboard> {
  TextEditingController family_name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  FocusScopeNode node = FocusScopeNode();
  String? gender;
  bool value = false;
  String? selectedValue;
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formkey3 = GlobalKey<FormState>();
  List Gender = [
    strings.Gender_Male,
    strings.Gender_Female,
    strings.Gender_Other
  ];
  late String select;
  /* void getDropDownItem() {
    setState(() {
      holder = selectedValue ?? "";
    });
  } */

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Center(
            child: Text(
          strings.RegFam,
        )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.Background),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 50, backgroundImage: AssetImage(AssetPath.AppLogo)),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                  child: AppInputText(
                    text: strings.RegFamMem,
                    colors: Colors.white,
                    size: 28,
                    weight: FontWeight.w600,
                  ),
                ),
                AppInputTextfield(
                  hintText: strings.RegFam_Hint_FamMemName,
                  nameController: family_name,
                  errorMessage: strings.RegFam_ErrorMsg_Name,
                  input_type: TextInputType.text,
                  obsecuretext: false,
                  action: TextInputAction.next,
                  node: node,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  globalKey: _formkey1,
                ),
                AppInputTextfield(
                  hintText: strings.RegFam_Hint_Age,
                  nameController: age,
                  errorMessage: strings.RegFam_ErrorMsg_Age,
                  input_type: TextInputType.number,
                  obsecuretext: false,
                  action: TextInputAction.next,
                  node: node,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  globalKey: _formkey2,
                ),
                AppInputTextfield(
                  hintText: strings.RegFam_Hint_Mobile,
                  nameController: mobileNumber,
                  errorMessage: strings.RegFam_ErrorMsg_Mobile,
                  input_type: TextInputType.number,
                  obsecuretext: false,
                  action: TextInputAction.next,
                  node: node,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  length: 10,
                  //lengthRequired: 10,
                  globalKey: _formkey3,
                ),
                Container(
                  width: 330,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          strings.Gender_SelectHeader,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: Container(
                          width: 330,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              addRadioButton(0, strings.Gender_Male),
                              addRadioButton(1, strings.Gender_Female),
                              addRadioButton(2, strings.Gender_Other),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ButtonComponent(
                    onPressed: () async {
                      if (_formkey1.currentState!.validate() &&
                          _formkey2.currentState!.validate() &&
                          selectedValue != null) {
                        // EasyLoading.show();
                        final registered_famList = registrationFamilyModel(
                            mpin: "-",
                            age: age.text,
                            name: family_name.text,
                            gender: selectedValue,
                            mobile: mobileNumber.text);
                        final DatabaseHelper _databaseService =
                            DatabaseHelper.instance;
                        final saved = await _databaseService.insertInto(
                            registered_famList.toJson(), DatabaseHelper.table);
                        print("data saved $saved");
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.dashboardGridview);
                        showToast(strings.ToastMsg_FamAdded);
                      } else if (_formkey1.currentState!.validate() &&
                          _formkey2.currentState!.validate() &&
                          _formkey3.currentState!.validate() &&
                          (mobileNumber.text.length < 10 ||
                              mobileNumber.text.length > 10)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "MOBILE NUMBER INVALID",
                              descriptions: strings.MobileAlert,
                              Buttontext: 'OK',
                              img: Image.asset(AssetPath.WarningBlueIcon),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      } else if (selectedValue == null) {
                        showToast(strings.GenderText);
                      }
                    },
                    buttonText: strings.ButtonSubmit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Colors.white,
          value: Gender[btnValue],
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              print(value);
              selectedValue = value;
            });
          },
        ),
        Text(
          title,
          style: RadioTextSTyle,
        )
      ],
    );
  }
}
