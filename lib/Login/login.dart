import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/Constants/assetsPath.dart';
import 'package:medicineinventory/Database/database_helper.dart';
import 'package:medicineinventory/Reusable/app_input_text.dart';
import 'package:medicineinventory/Reusable/app_input_textfield.dart';
import 'package:medicineinventory/Reusable/button_component.dart';
import 'package:medicineinventory/Routes/App_routes.dart';
import 'package:medicineinventory/modelClasses/pass_number_to_validateMpin.dart';
import '../CustomAlerts/customAlerts.dart';
import '../notifier/mobile_notifier.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mobile = TextEditingController();
  TextEditingController _password = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  int? flag;
  List<String> mobileList = []; //for database mobile numbers
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    MobileProvider mobileProvider =
        Provider.of<MobileProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () => _backPressed(),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetPath.Background),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(AssetPath.AppLogo)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppInputText(
                        text: strings.LoginText,
                        colors: Colors.white,
                        size: 20,
                        weight: FontWeight.bold),
                  ),
                  AppInputTextfield(
                    length: 10,
                    hintText: strings.RegFam_Hint_Mobile,
                    nameController: _mobile,
                    errorMessage: strings.RegFam_ErrorMsg_Mobile,
                    input_type: TextInputType.number,
                    obsecuretext: false,
                    node: _node,
                    action: TextInputAction.next,
                    onEditingComplete: () {
                      _node.nextFocus();
                    },
                    //lengthRequired: 10,
                    globalKey: _formkey1,
                  ),
                  /* AppInputTextfield(
                  hintText: 'Password',
                  nameController: _password,
                  errorMessage: 'Please Enter Mobile Number',
                  input_type: TextInputType.number,
                  obsecuretext: !_isPasswordVisible,
                  node: _node,
                  action: TextInputAction.next,
                  onEditingComplete: () {
                    _node.nextFocus();
                  },
                  globalKey: _formkey2,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey),
                  ),
                ), */
                  /* Center(
                    child: TextButton(
                        onPressed: () {}, child: Text('Forgot Password'))), */
                  ButtonComponent(
                      onPressed: () {
                        if (_formkey1.currentState!
                                .validate() /* &&
                          _formkey2.currentState!.validate() */
                            ) {}
                        if (validateInputs()) {
                          /*  for (var j = 0; j < mobileList.length; j++) {
                          print('number is ${mobileList[j]}');
                          print('number2 is ${_username.text}');
                          if (mobileList[j] == _username.text) {
                            print('true');
                            Navigator.pushNamed(
                                context, AppRoutes.mpinValidate);
                          } else {
                            showAlert('Please enter valid mobile number');
                          }
                        } */
                          mobileProvider.saveName(_mobile.text);
                          LoginCall(_mobile.text);
                          /* if (flag == 1) {
                          showAlert('No data found.... Please SignUp');
                        } */
                        }
                      },
                      buttonText: strings.LoginText),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppInputText(
                          text: strings.AccountCheck,
                          colors: Colors.black,
                          size: 15,
                          weight: FontWeight.w300),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.registraion);
                        },
                        child: Text(
                          strings.SignUp,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validateInputs() {
    if (_mobile.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Mobile Number cannot be empty",
              descriptions: strings.LoginAlert_enterMobile,
              Buttontext: strings.Presc_Ok,
              img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          });
      return false;
    } else if (_mobile.text.length < 10) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "MOBILE NUMBER INVALID",
              descriptions: strings.LoginAlert_Invalid,
              Buttontext: strings.Presc_Ok,
              img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
      return false;
    } /* else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(_password.text)) {
      showAlert("Please Enter a Valid Password");
    } */
    else {
      return true;
    }
  }

  LoginCall(String mobileNumber) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.queryRowCountforuser(
        DatabaseHelper.table, mobileNumber);
    final users = await _databaseService.queryRowCount();
    print("data saved ${saved}");
    flag = saved;
    print('flag is $flag');

    if (flag == 0 && users != 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Invalid User mobile number",
              descriptions: strings.LoginAlert_InvalidMobile,
              Buttontext: strings.Presc_Ok,
              img: Image.asset(AssetPath.WarningBlueIcon),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    } else if (users == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "User Not found",
              descriptions: strings.LoginAlert_signUp,
              Buttontext: strings.Presc_Ok,
              img: Image.asset(AssetPath.CrossIcon),
              bgColor: Colors.red[900],
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    } else {
      Navigator.pushNamed(context, AppRoutes.mpinValidate,
          arguments: ScreenArguments(_mobile.text));
    }
    // print('mobile number is${saved[0]['mobileNumber']}');
    /* for (var i = 0; i < saved.length; i++) {
      // print('mobile numbers are ${saved[i]["mobileNumber"]}');
      mobileList.add({saved[i]["mobileNumber"]}.toString());
    }
    print(mobileList); */
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _mobile.text = '1111111111';
  }

  Future<bool> _backPressed() async {
    SystemNavigator.pop();
    return true;
  }
}
