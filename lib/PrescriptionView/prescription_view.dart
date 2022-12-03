import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/date_picker.dart';


class viewPrescription extends StatefulWidget {
  const viewPrescription({super.key});

  @override
  State<viewPrescription> createState() => _viewPrescriptionState();
}

class _viewPrescriptionState extends State<viewPrescription> {
  TextEditingController _famName = TextEditingController();
  TextEditingController _medicineName = TextEditingController();
  TextEditingController _symptom = TextEditingController();
  TextEditingController _expiryDate = TextEditingController();
  TextEditingController _hospitalName = TextEditingController();
  TextEditingController _appointment = TextEditingController();
  TextEditingController _doctorName = TextEditingController();
  TextEditingController _reason = TextEditingController();
  TextEditingController _next = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formkey3 = GlobalKey<FormState>();
  final _formkey4 = GlobalKey<FormState>();
  List<PlatformFile> files_list = [];
  FilePickerResult? result;
  String textt = 'Hello World';

  dynamic placeholder = NetworkImage(
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg');

  //File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Family Member Name'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                AppInputTextfield(
                    hintText: 'symptom ',
                    nameController: _symptom,
                    errorMessage: 'please enter symptom',
                    input_type: TextInputType.text,
                    obsecuretext: false,
                    node: _node,
                    action: TextInputAction.next,
                    onEditingComplete: () {
                      _node.nextFocus();
                    },
                    globalKey: _formkey1),
                AppInputTextfield(
                    hintText: 'Medicine Name',
                    nameController: _medicineName,
                    errorMessage: 'please enter medicine name',
                    input_type: TextInputType.text,
                    obsecuretext: false,
                    node: _node,
                    action: TextInputAction.next,
                    onEditingComplete: () {
                      _node.nextFocus();
                    },
                    globalKey: _formkey2),
                datePickerComponent(
                    hintText: 'Expiry date',
                    nameController: _expiryDate,
                    errorMessage: 'Please enter expiry date',
                    obsecuretext: false,
                    node: _node,
                    action: TextInputAction.next,
                    onEditingComplete: () {
                      _node.nextFocus();
                    },
                    globalKey: _formkey3),
              ],
            ),
            AppInputTextfield(
              hintText: 'Hospital Name',
              nameController: _hospitalName,
              errorMessage: 'please enter hospital name',
              input_type: TextInputType.text,
              obsecuretext: false,
              node: _node,
              action: TextInputAction.next,
              onEditingComplete: () {
                _node.nextFocus();
              },
            ),
            datePickerComponent(
              hintText: 'Date of Appointment',
              nameController: _appointment,
              errorMessage: 'Please enter appointment date',
              obsecuretext: false,
              node: _node,
              action: TextInputAction.next,
              onEditingComplete: () {
                _node.nextFocus();
              },
            ),
            AppInputTextfield(
              hintText: 'Doctor Name',
              nameController: _doctorName,
              errorMessage: 'please enter doctor name',
              input_type: TextInputType.text,
              obsecuretext: false,
              node: _node,
              action: TextInputAction.next,
              onEditingComplete: () {
                _node.nextFocus();
              },
            ),
            AppInputTextfield(
              hintText: 'Reason for Appointment',
              nameController: _reason,
              errorMessage: 'please enter reason for appointment',
              input_type: TextInputType.text,
              obsecuretext: false,
              node: _node,
              action: TextInputAction.next,
              onEditingComplete: () {
                _node.nextFocus();
              },
            ),
            datePickerComponent(
              hintText: 'Next Appointment Date',
              nameController: _expiryDate,
              errorMessage: 'Please enter next Appointment date',
              obsecuretext: false,
              node: _node,
              action: TextInputAction.next,
              onEditingComplete: () {
                _node.nextFocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}
