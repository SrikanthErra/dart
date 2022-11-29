import 'package:flutter/material.dart';
import 'package:side_menu/Reusable/alert.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/database_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  var dbHelper;
  List<String> mobileList = []; //for database mobile numbers
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("login")),
      body: Form(
        key: _formKey,
        child: Center(
          child: Card(
            surfaceTintColor: Colors.grey,
            shadowColor: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppInputText(
                      text: 'Login',
                      colors: Colors.black,
                      size: 20,
                      weight: FontWeight.bold),
                ),
                AppInputTextfield(
                  hintText: 'Username/Mobile Number',
                  nameController: _username,
                  errorMessage: 'Please Enter username',
                  input_type: TextInputType.text,
                  obsecuretext: false,
                  node: _node,
                  action: TextInputAction.next,
                  onEditingComplete: () {
                    _node.nextFocus();
                  },
                  globalKey: _formkey1,
                ),
                AppInputTextfield(
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
                ),
                Center(
                    child: TextButton(
                        onPressed: () {}, child: Text('Forgot Password'))),
                ButtonComponent(
                    onPressed: () {
                      if (_formkey1.currentState!.validate()) {}
                      if (_formkey2.currentState!.validate()) {}
                      if (validateInputs()) {
                        for (var j = 0; j < mobileList.length; j++) {
                          if (mobileList[j] == _username.text) {
                            Navigator.pushNamed(
                                context, AppRoutes.mpinValidate);
                          } 
                          else {
                            showAlert('Please enter valid mobile number');
                          }
                        }
                      }
                    },
                    buttonText: 'Login'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppInputText(
                        text: 'Didnt have any account?',
                        colors: Colors.grey,
                        size: 15,
                        weight: FontWeight.w300),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.registraion);
                        },
                        child: Text(
                          'Sign Up here',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateInputs() {
   /*  if (_username.text.isEmpty) {
      showAlert("Please enter email");
    } else if (_password.text.isEmpty) {
      showAlert("Please enter Mobile Number");
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(_password.text)) {
      showAlert("Please Enter a Valid Password");
    } else {
      return true;
    } */
  }

  showAlert(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppShowAlert(message: message);
        });
  }

  Future<void> LoginCall(String username, String pwd) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.queryLogin(DatabaseHelper.table);
    print("data saved ${saved}");
    // print('mobile number is${saved[0]['mobileNumber']}');
    for (var i = 0; i < saved.length; i++) {
      // print('mobile numbers are ${saved[i]["mobileNumber"]}');
      mobileList.add({saved[i]["mobileNumber"]}.toString());
    }
    print(mobileList);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoginCall(_username.text, _password.text);
  }
}
