import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('LogIn Page')),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Enter email",
                hintStyle: TextStyle(
                  color: Colors.yellow,
                  fontStyle: FontStyle.italic,
                )),
            cursorColor: Colors.red,
            obscureText: false,
            keyboardType: TextInputType.number,
            controller: _emailController,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Enter password',
              hintStyle: TextStyle(
                color: Colors.yellow,
                fontStyle: FontStyle.italic,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 5, color: Colors.green),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 5, color: Colors.black),
              ),
            ),
            cursorColor: Colors.red,
            maxLength: 10,
            obscureText: false,
            keyboardType: TextInputType.number,
            controller: _password,
          ),
        ),
        TextButton(
            onPressed: () {
              ValidateInputs();
            },
            child: Text('LogIN')),
      ]),
    );
  }

  ValidateInputs() {
    if (_emailController.text.isEmpty) {
      showAlert('Please enter email');
    } else if (_password.text.isEmpty) {
      showAlert('Please enter password');
    }
  }

  showAlert(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }
}
