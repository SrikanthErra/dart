import 'package:flutter/material.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Routes/App_routes.dart';

import 'Reusable/button_component.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('assets/pqms.jpeg',
                  width: 100, height: 50, fit: BoxFit.fill),
            ), */
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
                onPressed: () {
                  if (_formkey1.currentState!.validate()) {}
                  if (_formkey2.currentState!.validate()) {}
                  Navigator.pushNamed(context, AppRoutes.mpinValidate);
                },
                buttonText: 'Proceed'),
          ],
        ),
      ),
    );
  }
}
