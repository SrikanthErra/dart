import 'package:flutter/material.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';

import 'Reusable/button_component.dart';

class otp extends StatefulWidget {
  const otp({super.key});

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
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
                  text: 'OTP',
                  colors: Colors.black,
                  size: 30,
                  weight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppInputText(
                  text: 'Enter 4 digit OTP',
                  colors: Colors.black,
                  size: 15,
                  weight: FontWeight.bold),
            ),
            AppInputTextfield(
                hintText: 'Enter OTP',
                nameController: _mpin,
                errorMessage: 'please enter OTP',
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
                          
                        },
                        buttonText: 'Submit'),
          ],
        ),
      ),
    );
  }
}
