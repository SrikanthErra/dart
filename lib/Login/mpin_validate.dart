import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:side_menu/Constants/StringConstants.dart';
import 'package:side_menu/Constants/assetsPath.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/pass_number_to_validateMpin.dart';
import 'package:side_menu/Reusable/alert.dart';
import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Database/database_helper.dart';

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
  late String mpin;
  Map mpin_value = {};
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.Background),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 60, backgroundImage: AssetImage(AssetPath.AppLogo)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppInputText(
                    text: strings.Mpin_validate,
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
                obscureText: true,
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
                borderColor: Colors.grey,
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
              ButtonComponent(
                  onPressed: () {
                    if (_mpin.text.isNotEmpty && _mpin.text.length == 4) {
                      LoginCall(arg.phoneNumber, _mpin.text);
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AppShowAlert(message: strings.Mpin_Alert);
                          });
                    }
                  },
                  buttonText: strings.ButtonValidate),
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
    if (mpin_value['mpin'] == mpin) {
      await EasyLoading.show(
          status: strings.Loader, maskType: EasyLoadingMaskType.black);
      Navigator.pushReplacementNamed(context, AppRoutes.dashboardGridview);
    } else {
      showAlert(strings.Mpin_validation);
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
