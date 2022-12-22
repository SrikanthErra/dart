import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';

class MultiselectDropdown extends StatefulWidget {
  MultiselectDropdown({super.key});
  static List<dynamic> dropdownList = [
    'Fever',
    'Cold',
    "Cough",
    "Headache",
    'Others'
  ];

  @override
  State<MultiselectDropdown> createState() => _MultiselectDropdownState();
}
class _MultiselectDropdownState extends State<MultiselectDropdown> {
  bool? flag;

  final _items = MultiselectDropdown.dropdownList
      .map((symptom) => MultiSelectItem<dynamic>(symptom, symptom))
      .toList();

  @override
  Widget build(BuildContext context) {
    List subjectData = [];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Multi Select DropDown"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MultiSelectDialogField(
              items: _items,
              title: const Text(
                "Select Subject",
                style: TextStyle(color: Colors.black),
              ),
              selectedColor: Colors.black,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              buttonIcon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.blue,
              ),
              buttonText: const Text(
                "Select Your Subject",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onConfirm: (results) {
                subjectData = [];
                for (var i = 0; i < results.length; i++) {
                  subjectData.add(results[i]);
                }

                if (subjectData.contains('Others')) {
                  print('hello');
                  setState(() {
                    flag = true;
                  });
                } else {
                  setState(() {
                    flag = false;
                  });
                }
                print(results.toString());
                print("data $subjectData");
              },
            ),
          ),
          Visibility(
            visible: flag ?? false,
            child:
                //AppInputTextfield(hintText: 'Please enter Symptoms', nameController: nameController, errorMessage: errorMessage, input_type: input_type, obsecuretext: obsecuretext, node: node, action: action, onEditingComplete: onEditingComplete)
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Symptoms',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //setState(() {});
  }
}
