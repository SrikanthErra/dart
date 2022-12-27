import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

import 'image_picker.dart';

class combinedDropdown extends StatefulWidget {
  const combinedDropdown({super.key});

  @override
  State<combinedDropdown> createState() => _combinedDropdownState();
}

class _combinedDropdownState extends State<combinedDropdown> {
  TextEditingController _symptom = TextEditingController();
  String? selectedValue;
  static List<dynamic> CombineddropdownList = [
    'Fever',
    'Cold',
    'Cough',
    'Fever,Cold',
    'Fever,Cough',
    'Cold,Cough',
    'Fever,Cold,Cough',
    'Others'
  ];
   XFile imageData1 = XFile("");
  XFile imageData2 = XFile("");
  XFile imageData3 = XFile("");
  bool? flag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Combined Multi Select DropDown"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              //focusColor: Colors.white,
              dropdownColor: Colors.blueGrey,
              decoration: InputDecoration(
                labelText: 'Symptoms',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Please enter Symptoms',
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
              ),

              value: selectedValue,
              items:
                  CombineddropdownList.map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ))).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                  if (selectedValue == 'Others') {
                    print('Hello');
                    setState(() {
                      flag = true;
                    });
                  } else {
                    setState(() {
                      flag = false;
                    });
                  }
                  // getId(selectedValue ?? "");
                });
                /* print('Id is $selectedId');
                                print('Result is ${familyNamesStateProvider.FamilyNames.map(
                                    (e) => e.FamilyMemberId)}'); */
              },
              style: TextStyle(color: Colors.white),
            ),
          ),
          Visibility(
            visible: flag ?? false,
            child:
                //AppInputTextfield(hintText: 'Please enter Symptoms', nameController: nameController, errorMessage: errorMessage, input_type: input_type, obsecuretext: obsecuretext, node: node, action: action, onEditingComplete: onEditingComplete)
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _symptom,
                decoration: InputDecoration(
                  labelText: 'Enter Symptoms',
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                int index = CombineddropdownList.length;
                if (flag == true) {
                  setState(() {
                    CombineddropdownList.insert((index - 1), _symptom.text);
                  });
                }

                print(CombineddropdownList);
              },
              child: Text('Submit')),
              ImgPickerCamera(callbackValue: (imageData) {
                              imageData1 = imageData;
                              // print("path1:${imageData1.path}");
                            },)

        ],
      ),
    );
  }
}
