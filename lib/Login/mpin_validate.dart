import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/Constants/appColor.dart';
import 'package:medicineinventory/Constants/assetsPath.dart';
import 'package:medicineinventory/Reusable/app_input_text.dart';
import 'package:medicineinventory/Routes/App_routes.dart';
import 'package:medicineinventory/modelClasses/pass_number_to_validateMpin.dart';
import 'package:medicineinventory/Reusable/button_component.dart';
import 'package:medicineinventory/Database/database_helper.dart';
import '../CustomAlerts/customAlerts.dart';

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
                    size: 25,
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.ResetMpin,
                            arguments: arg.phoneNumber);
                      },
                      child: Text(
                        "Forgot MPIN?",
                        style: TextStyle(
                          shadows: [
                            Shadow(color: Colors.black, offset: Offset(0, -5))
                          ],
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.navy,
                          decorationThickness: 4,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ButtonComponent(
                  onPressed: () {
                    if (_mpin.text.isNotEmpty && _mpin.text.length == 4) {
                      LoginCall(arg.phoneNumber, _mpin.text);
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "INVALID MPIN",
                              descriptions: strings.Mpin_Alert,
                              Buttontext: strings.Presc_Ok,
                              img: Image.asset(AssetPath.WarningIcon),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
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
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "WRONG MPIN",
              descriptions: strings.Mpin_validation,
              Buttontext: strings.Presc_Ok,
              img: Image.asset(AssetPath.CrossIcon),
              onPressed: () {
                Navigator.of(context).pop();
              },
              bgColor: Colors.red[900],
            );
          });
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
