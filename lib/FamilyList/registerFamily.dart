import 'package:flutter/material.dart';
import 'package:flutter_group_button/flutter_group_button.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Reusable/toast.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/registration_familyList_model.dart';
import 'package:side_menu/Database/database_helper.dart';
import 'package:uuid/uuid.dart';
class registerFamilyFromDashboard extends StatefulWidget {
  const registerFamilyFromDashboard({super.key});

  @override
  State<registerFamilyFromDashboard> createState() =>
      _registerFamilyFromDashboardState();
}

class _registerFamilyFromDashboardState
    extends State<registerFamilyFromDashboard> {
  TextEditingController _family_name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _mobileNumber = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  String? gender;
  bool value = false;
  String? selectedValue;
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formkey3 = GlobalKey<FormState>();
  /* void getDropDownItem() {
    setState(() {
      holder = selectedValue ?? "";
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Center(child: Text('Register a Family'))),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/appLogo.png")),
              AppInputText(
                text: 'Register a family member',
                colors: Colors.white,
                size: 30,
                weight: FontWeight.w600,
              ),
              AppInputTextfield(
                hintText: 'Name of family Member',
                nameController: _family_name,
                errorMessage: 'please enter name',
                input_type: TextInputType.text,
                obsecuretext: false,
                action: TextInputAction.next,
                node: _node,
                onEditingComplete: () {
                  _node.nextFocus();
                },
                globalKey: _formkey1,
              ),
              AppInputTextfield(
                hintText: 'Age',
                nameController: _age,
                errorMessage: 'please enter age',
                input_type: TextInputType.number,
                obsecuretext: false,
                action: TextInputAction.next,
                node: _node,
                onEditingComplete: () {
                  _node.nextFocus();
                },
                globalKey: _formkey2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Select Gender:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  RadioListTile(
                    // contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Male",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    value: "male",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    //contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Female",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    value: "female",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    //contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Other",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    value: "other",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                ],
              ),
              AppInputTextfield(
                hintText: 'Mobile Number',
                nameController: _mobileNumber,
                errorMessage: 'please enter Mobile number',
                input_type: TextInputType.number,
                obsecuretext: false,
                action: TextInputAction.next,
                node: _node,
                onEditingComplete: () {
                  _node.nextFocus();
                },
                length: 10,
                //lengthRequired: 10,
                globalKey: _formkey3,
              ),
              ButtonComponent(
                  onPressed: () async {
                    if (_formkey1.currentState!.validate() &&
                        _formkey2.currentState!.validate() &&
                        _formkey3.currentState!.validate()) {
                      final registered_famList = registrationFamilyModel(
                          mpin: "-",
                          age: _age.text,
                          name: _family_name.text,
                          gender: gender,
                          mobile: _mobileNumber.text);
                      final DatabaseHelper _databaseService =
                          DatabaseHelper.instance;
                      final saved = await _databaseService.insertInto(
                          registered_famList.toJson(), DatabaseHelper.table);
                      print("data saved $saved");
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.dashboardGridview);
                      showToast("Family Member Added");
                      //getDropDownItem();
                    }
                  },
                  buttonText: 'Submit'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _node.dispose();
    super.dispose();
  }
}
