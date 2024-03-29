import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/Constants/assetsPath.dart';
import 'package:medicineinventory/Reusable/app_input_text.dart';
import 'package:medicineinventory/Routes/App_routes.dart';
import 'package:medicineinventory/modelClasses/registration_familyList_model.dart';
import 'package:medicineinventory/Reusable/button_component.dart';
import 'package:medicineinventory/Database/database_helper.dart';
import '../CustomAlerts/SuccessCutomAlerts.dart';
import '../CustomAlerts/customAlerts.dart';

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
      //resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.Background),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 60, backgroundImage: AssetImage(AssetPath.AppLogo)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppInputText(
                      text: strings.SetMpin,
                      colors: Colors.white,
                      size: 30,
                      weight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppInputText(
                      text: strings.Mpin_Hint,
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
                      text: strings.ConfimMpin,
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
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SuccessCustomAlert(
                                    title: 'MPIN SET SUCCESSFULLY',
                                    descriptions:
                                        'Mpin for user is set Successfully',
                                    Buttontext: 'OK',
                                    img: Image.asset(AssetPath.SuccessIcon),
                                    onPressed: () async {
                                      final registered_famList =
                                          registrationFamilyModel(
                                              mpin: _mpin.text,
                                              age: arg.age,
                                              name: arg.name,
                                              gender: arg.gender,
                                              mobile: arg.mobile);
                                      final DatabaseHelper _databaseService =
                                          DatabaseHelper.instance;
                                      final saved =
                                          await _databaseService.insertInto(
                                              registered_famList.toJson(),
                                              DatabaseHelper.table);
                                      print("data saved $saved");
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.login);
                                    },
                                  );
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: 'SET MPIN',
                                    descriptions: strings.Mpin_AlertNoMatch,
                                    Buttontext: 'OK',
                                    img: Image.asset(AssetPath.WarningBlueIcon),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                });
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: 'SET MPIN',
                                  descriptions: strings.Mpin_AlertConfirm,
                                  Buttontext: 'OK',
                                  img: Image.asset(AssetPath.WarningBlueIcon),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                );
                              });
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: 'SET MPIN',
                                descriptions: strings.Mpin_Alert,
                                Buttontext: 'OK',
                                img: Image.asset(AssetPath.WarningBlueIcon),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              );
                            });
                      }
                    },
                    buttonText: strings.ButtonProceed),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
