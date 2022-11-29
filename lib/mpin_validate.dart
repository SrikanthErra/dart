import 'package:flutter/material.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Routes/App_routes.dart';

import 'Reusable/button_component.dart';

class mpinValidate extends StatefulWidget {
  const mpinValidate({super.key});

  @override
  State<mpinValidate> createState() => _mpinValidateState();
}

class _mpinValidateState extends State<mpinValidate> {
  TextEditingController _mpin = TextEditingController();
  TextEditingController _confirm_mpin = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  final _formkey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppInputText(
                  text: 'Validate MPIN',
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
            ButtonComponent(
                onPressed: () {
                  if (_formkey1.currentState!.validate()) {}
                  Navigator.pushNamed(context, AppRoutes.login);
                },
                buttonText: 'Validate'),
          ],
        ),
      ),
    );
  }
}
