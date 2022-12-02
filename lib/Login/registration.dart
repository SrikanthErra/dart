import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_group_button/flutter_group_button.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/registration_familyList_model.dart';
import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Database/database_helper.dart';

class registerFamily extends StatefulWidget {
  const registerFamily({super.key});

  @override
  State<registerFamily> createState() => _registerFamilyState();
}

class _registerFamilyState extends State<registerFamily> {
  TextEditingController _family_name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _mobileNumber = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  //List<String> _gender = ["Male", "Female", "Others"];
  String? gender;

  //String holder = '';
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
      resizeToAvoidBottomInset: false,
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
                text: 'Registration',
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
              RadioGroup(
                  children: [
                    AppInputText(
                        text: 'Male',
                        colors: Colors.white,
                        size: 15,
                        weight: FontWeight.normal),
                    AppInputText(
                        text: 'Female',
                        colors: Colors.white,
                        size: 15,
                        weight: FontWeight.normal),
                    AppInputText(
                        text: 'Others',
                        colors: Colors.white,
                        size: 15,
                        weight: FontWeight.normal)
                  ],
                  groupItemsAlignment: GroupItemsAlignment.row,
                  mainAxisAlignment: MainAxisAlignment.start,
                  internMainAxisAlignment: MainAxisAlignment.start,

                  /// In reality this is not needed
                  // priority: RadioPriority.textBeforeRadio,
                  defaultSelectedItem: -1,
                  onSelectionChanged: (selection) {
                    print(selection);
                  }),
              Text(
                "Select Gender:",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
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

              /* Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppInputText(
                          text: 'Select Gender',
                          colors: Colors.white,
                          size: 20,
                          weight: FontWeight.normal),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          alignment: Alignment.centerLeft,
                          hint: Text(
                            'Select Gender',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          items: _gender
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    
                                    child: Text(
                                      item,
                                      
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: 140,
                          itemHeight: 40,
                        ),
                      ),
                    ]),
              ), */
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
                globalKey: _formkey3,
              ),
              ButtonComponent(
                  onPressed: () async {
                    if (_formkey1.currentState!.validate() &&
                        _formkey2.currentState!.validate() &&
                        _formkey3.currentState!.validate()) {
                      //getDropDownItem();
                    }
                    Navigator.pushReplacementNamed(context, AppRoutes.mpinPage,
                        arguments: registrationFamilyModel(
                            name: _family_name.text,
                            age: _age.text,
                            mobile: _mobileNumber.text,
                            gender: gender));
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
