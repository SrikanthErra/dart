import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/date_picker.dart';

import 'Reusable/button_component.dart';

class addPrescription extends StatefulWidget {
  const addPrescription({super.key});

  @override
  State<addPrescription> createState() => _addPrescriptionState();
}

class _addPrescriptionState extends State<addPrescription> {
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
      appBar: AppBar(
        title: Text('Add Prescription'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Column(
                  children: [
                    AppInputTextfield(
                        hintText: 'Family Member Name',
                        nameController: _famName,
                        errorMessage: 'please enter family member name',
                        input_type: TextInputType.text,
                        obsecuretext: false,
                        node: _node,
                        action: TextInputAction.next,
                        onEditingComplete: () {
                          _node.nextFocus();
                        },
                        globalKey: _formkey1),
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
                        globalKey: _formkey2),
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
                        globalKey: _formkey3),
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
                        globalKey: _formkey4),
                    /*  Container(
                      width: 100,
                      height: 100,
                      child: Image(image: placeholder),
                    ), */
                    ListView.builder(
                       scrollDirection: Axis.vertical,
                       shrinkWrap: true,
                        itemCount: files_list.length,
                        itemBuilder: (context, index) {
                          final file = files_list[index];
                          return buildFile(file);
                          //return Text('Hello');
                        }),
                    TextButton(
                      onPressed: () async {
                        final result = await FilePicker.platform
                            .pickFiles(withReadStream: true, allowMultiple: true);
                        if (result == null) return;
                        //  final files = result.files;
                        //   print(
                        //   'file is $files'); //EDIT: THIS PROBABLY CAUSED YOU AN ERROR
                        /* textt = result.files.first.path.toString();
                        print("test is $textt"); */
                        //  files_list = result.files;
                        files_list = result.paths
                            .map((path) => File(path ?? "")as PlatformFile)
                            .toList();
                        print('files picked are $files_list');
                        // placeholder = FileImage(File());
                        setState(() {});
                      },
                      child: Text('Upload File'),
                    )
                  ],
                ),
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
              ButtonComponent(
                  onPressed: () {
                    if (_formkey1.currentState!.validate()) {}
                    if (_formkey2.currentState!.validate()) {}
                    if (_formkey3.currentState!.validate()) {}
                    if (_formkey4.currentState!.validate()) {}
                  },
                  buttonText: 'Submit'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return Container(
      width: 100,
      height: 100,
      child: InkWell(
        onTap: () => null,
        child: Container(
          width: 200,
          height: 200,
          child: ListTile(
            leading: (file.extension == 'jpg' || file.extension == 'png')
                ? Image.file(
                    File(file.path.toString()),
                    width: 80,
                    height: 80,
                  )
                : Container(
                    width: 80,
                    height: 80,
                  ),
            title: Text('${file.name}'),
            subtitle: Text('${file.extension}'),
            trailing: Text(
              '$size',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
