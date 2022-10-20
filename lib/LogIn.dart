import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _number = new TextEditingController();
  TextEditingController _multiline = new TextEditingController();
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
                hintText: "Enter name",
                hintStyle: TextStyle(
                  color: Colors.yellow,
                  fontStyle: FontStyle.italic,
                )),
            cursorColor: Colors.red,
            maxLength: 10,
            controller: _name,
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
            obscureText: true,
            controller: _password,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Enter number",
                hintStyle: TextStyle(
                  color: Colors.yellow,
                  fontStyle: FontStyle.italic,
                )),
            cursorColor: Colors.red,
            maxLength: 10,
            keyboardType: TextInputType.number,
            controller: _number,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Enter description",
                hintStyle: TextStyle(
                  color: Colors.yellow,
                  fontStyle: FontStyle.italic,
                )),
            cursorColor: Colors.red,
            maxLines: null,
            controller: _multiline,
          ),
        ),
      ]),
    );
  }
}
