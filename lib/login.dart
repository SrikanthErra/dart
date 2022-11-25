import 'package:flutter/material.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Routes/App_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
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
                  hintText: 'Username',
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
                  nameController: _passwordController,
                  errorMessage: 'Please Enter Password',
                  input_type: TextInputType.visiblePassword,
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
                        Navigator.pushNamed(context, AppRoutes.dashboard);
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
                          Navigator.pushNamed(
                              context, AppRoutes.registraion);
                        },
                        child: Text(
                          'Sign Up here',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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
    if (_username.text.isEmpty) {
      showAlert("Please enter email");
    } else if (_passwordController.text.isEmpty) {
      showAlert("Please enter password");
    } /* else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      showAlert("Please Enter Valid Email");
    } */ /* else if (!RegExp(
            r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{8,}')
        .hasMatch(_passwordController.text)) {
      showAlert("Please Enter Valid Password");
    }  */else {
      return true;
    }
  }

  showAlert(String message, {String text = ""}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message + text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("ok"),
              )
            ],
          );
        });
  }
}
