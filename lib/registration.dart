import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/registration_familyList_model.dart';

import 'Reusable/alert.dart';
import 'database_helper.dart';

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
  List<String> _gender = ["Male", "Female", "Others"];

  String holder = '';
  bool value = false;
  String? selectedValue;
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formkey3 = GlobalKey<FormState>();
  void getDropDownItem() {
    setState(() {
      holder = selectedValue ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Center(child: Text('Register a Family'))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppInputText(
            text: 'Registration',
            colors: Colors.black,
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppInputText(
                      text: 'Select Gender',
                      colors: Colors.black,
                      size: 20,
                      weight: FontWeight.normal),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      alignment: Alignment.centerLeft,
                      hint: Text(
                        'Select Gender',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: _gender
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
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
          ),
          Text('Selected Item = ' + '$holder',
              style: TextStyle(fontSize: 22, color: Colors.black)),
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
                  getDropDownItem();
                }
                Navigator.pushNamed(context, AppRoutes.mpinPage,
                    arguments: registrationFamilyModel(
                        name: _family_name.text,
                        age: _age.text,
                        mobile: _mobileNumber.text,
                        gender: holder));
              },
              buttonText: 'Submit'),
        ],
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
