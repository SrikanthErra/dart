

import 'package:flutter/material.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/pass_number_to_validateMpin.dart';

import 'Reusable/alert.dart';
import 'Reusable/button_component.dart';
import 'database_helper.dart';

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
  Map mpin_value = {};
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_bg.png"),
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
                    LoginCall(arg.phoneNumber, _mpin.text);
                  },
                  buttonText: 'Validate'),
            ],
          ),
        ),
      ),
    );
  }

  showAlert(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppShowAlert(message: message);
        });
  }

  LoginCall(String phoneNumber, String mpin) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.queryRowCountforMpinValidate(
        DatabaseHelper.table, phoneNumber);
    print("data saved ${saved}");
    mpin_value = saved[0];
    if(mpin_value['mpin'] == mpin)
    {
      Navigator.pushNamed(context, AppRoutes.dashboardGridview);
    }
    else{
        showAlert('Please Enter Valid MPIN');
    }
    /* flag = saved;
    print('flag is $flag');
    if (flag == 0) {
      showAlert('Please Enter Valid MPIN');
    } else if (flag == 1) {
      Navigator.pushNamed(context, AppRoutes.dashboardGridview);
    } */
  }
}
