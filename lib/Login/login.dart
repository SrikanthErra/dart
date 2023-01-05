import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:side_menu/Constants/StringConstants.dart';
import 'package:side_menu/Constants/assetsPath.dart';
import 'package:side_menu/Database/database_helper.dart';
import 'package:side_menu/Reusable/alert.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/modelClasses/pass_number_to_validateMpin.dart';
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
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))
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
      showAlert(strings.LoginAlert_enterMobile);
    } else if (_mobile.text.length < 10) {
      showAlert(strings.LoginAlert_Invalid);
    } /* else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(_password.text)) {
      showAlert("Please Enter a Valid Password");
    } */
    else {
      return true;
    }
  }

  showAlert(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppShowAlert(message: message);
        });
  }

  LoginCall(String mobileNumber) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.queryRowCountforuser(
        DatabaseHelper.table, mobileNumber);
    print("data saved ${saved}");
    flag = saved;
    print('flag is $flag');
    if (flag == 0) {
      showAlert(strings.LoginAlert_signUp);
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
