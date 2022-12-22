import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:side_menu/Reusable/alert.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/registration_familyList_model.dart';

import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Database/database_helper.dart';

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
  late String mpin, confirmMpin;

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)?.settings.arguments as registrationFamilyModel;
    print(arg.mobile);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
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
              CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/appLogo.png")),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppInputText(
                    text: 'Set MPIN',
                    colors: Colors.white,
                    size: 30,
                    weight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppInputText(
                    text: 'Enter 4 digit MPIN',
                    colors: Colors.white,
                    size: 15,
                    weight: FontWeight.bold),
              ),
              PinCodeFields(
                length: 4,
                fieldBorderStyle: FieldBorderStyle.square,
                controller: _mpin,
                responsive: false,
                fieldHeight: 40.0,
                fieldWidth: 40.0,
                borderWidth: 1.0,
                activeBorderColor: Colors.grey,
                activeBackgroundColor: Colors.blue[100],
                borderRadius: BorderRadius.circular(10.0),
                keyboardType: TextInputType.number,
                autoHideKeyboard: true,
                fieldBackgroundColor: Colors.black12,
                borderColor: Colors.black38,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                onComplete: (mpinOutput) {
                  // Your logic with pin code
                  print(mpinOutput);
                  _mpin.text = mpinOutput;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: AppInputText(
                    text: 'Confirm 4 digit MPIN',
                    colors: Colors.white,
                    size: 15,
                    weight: FontWeight.bold),
              ),
              PinCodeFields(
                length: 4,
                fieldBorderStyle: FieldBorderStyle.square,
                controller: _confirm_mpin,
                responsive: false,
                fieldHeight: 40.0,
                fieldWidth: 40.0,
                borderWidth: 1.0,
                activeBorderColor: Colors.grey,
                activeBackgroundColor: Colors.blue[100],
                borderRadius: BorderRadius.circular(10.0),
                keyboardType: TextInputType.number,
                autoHideKeyboard: true,
                fieldBackgroundColor: Colors.black12,
                borderColor: Colors.black38,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                onComplete: (confirm_mpinOutput) {
                  // Your logic with pin code
                  print(confirm_mpinOutput);
                  _confirm_mpin.text = confirm_mpinOutput;
                },
              ),
              ButtonComponent(
                  onPressed: () async {
                    if (_mpin.text.length == 4 && _mpin.text.isNotEmpty) {
                      if (_confirm_mpin.text.length == 4 &&
                          _confirm_mpin.text.isNotEmpty) {
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
                              registered_famList.toJson(),
                              DatabaseHelper.table);
                          print("data saved $saved");
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.login);
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AppShowAlert(
                                    message:
                                        "MPINs doesn't match Please Check..!!");
                              });
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AppShowAlert(
                                  message:
                                      "Please Enter above MPIN correctly to confirm");
                            });
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AppShowAlert(
                                message: "Please Enter 4 digit MPIN");
                          });
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
