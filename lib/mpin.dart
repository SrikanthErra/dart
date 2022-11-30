import 'package:flutter/material.dart';
import 'package:side_menu/Reusable/alert.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/registration_familyList_model.dart';

import 'Reusable/button_component.dart';
import 'database_helper.dart';

class mpinPage extends StatefulWidget {
  const mpinPage({super.key});

  @override
  State<mpinPage> createState() => _mpinPageState();
}

class _mpinPageState extends State<mpinPage> {
  TextEditingController _mpin = TextEditingController();
  TextEditingController _confirm_mpin = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)?.settings.arguments as registrationFamilyModel;
    print(arg.mobile);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppInputText(
                    text: 'Set MPIN',
                    colors: Colors.black,
                    size: 30,
                    weight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppInputText(
                    text: 'Enter 4 digit MPIN',
                    colors: Colors.black,
                    size: 15,
                    weight: FontWeight.bold),
              ),
              AppInputTextfield(
                  hintText: 'Enter 4 digit MPIN',
                  nameController: _mpin,
                  errorMessage: 'please enter MPIN',
                  input_type: TextInputType.number,
                  obsecuretext: false,
                  node: _node,
                  action: TextInputAction.next,
                  onEditingComplete: () {
                    _node.nextFocus();
                  },
                  globalKey: _formkey1),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: AppInputText(
                    text: 'Confirm 4 digit MPIN',
                    colors: Colors.black,
                    size: 15,
                    weight: FontWeight.bold),
              ),
              AppInputTextfield(
                  hintText: 'Confirm 4 digit MPIN',
                  nameController: _confirm_mpin,
                  errorMessage: 'please enter MPIN to confirm',
                  input_type: TextInputType.number,
                  obsecuretext: false,
                  node: _node,
                  action: TextInputAction.next,
                  onEditingComplete: () {
                    _node.nextFocus();
                  },
                  globalKey: _formkey2),
              ButtonComponent(
                  onPressed: () async {
                    if (_formkey1.currentState!.validate() &&
                        _formkey2.currentState!.validate()) {
                      if (_mpin.text == _confirm_mpin.text) {
                        final registered_famList = registrationFamilyModel(
                            mpin: _mpin.text,
                            age: arg.age,
                            name: arg.name,
                            gender: arg.gender,
                            mobile: arg.mobile);
                        final DatabaseHelper _databaseService =
                            DatabaseHelper.instance;
                        final saved = await _databaseService.insertInto(
                            registered_famList.toJson(), DatabaseHelper.table);
                        print("data saved $saved");
                        Navigator.pushNamed(context, AppRoutes.login);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AppShowAlert(
                                  message: 'Please enter correct MPIN');
                            });
                      }
                    }
                  },
                  buttonText: 'Proceed'),
            ],
          ),
        ),
      ),
    );
  }
}
