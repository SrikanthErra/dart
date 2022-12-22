import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Database/database_helper.dart';
import 'modelClasses/symptoms_model.dart';

class autocomplete extends StatefulWidget {
  const autocomplete({super.key});

  @override
  State<autocomplete> createState() => _autocompleteState();
}

class _autocompleteState extends State<autocomplete> {
  TextEditingController _symptom = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  String? selectedSymptomValue;
  int? selectedSymptomId;
  bool? flag;
  bool stag = false;
  //static List<SymptomsModelClass> symptomsTableData = [];
  // List<Map<String, dynamic>> SymptomsDataList = [{}];
  List<String> SymptomsDataList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Combined Multi Select DropDown"),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //color: Colors.amber,
              decoration: BoxDecoration(
                //color: const Color(0xff7c94b6),

                border: Border.all(
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Autocomplete<String>(
                onSelected: (String selectedItem) {
                  selectedSymptomValue = selectedItem;
                  if (selectedSymptomValue == 'Others') {
                    print('Hello');
                    setState(() {
                      flag = true;
                    });
                  } else {
                    setState(() {
                      flag = false;
                    });
                  }
                },
                fieldViewBuilder: (BuildContext context, textEditingController,
                    FocusNode focusNode, VoidCallback onFieldSubmitted) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(hintText: "Select Symptom"),
                      focusNode: focusNode,
                      onFieldSubmitted: (String value) {
                        onFieldSubmitted();
                        print('text is ${textEditingController.text}');
                        print('You just typed a new entry  $value');
                      },
                    ),
                  );
                },
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return Iterable<String>.empty();
                  } else {
                    return SymptomsDataList.where((String item) {
                      final result = item
                          .toLowerCase()
                          .startsWith(textEditingValue.text.toLowerCase());
                      return result;
                    });
                  }
                },
              ),
            ),
          ),
          Visibility(
            visible: flag ?? false,
            child:
                //AppInputTextfield(hintText: 'Please enter Symptoms', nameController: nameController, errorMessage: errorMessage, input_type: input_type, obsecuretext: obsecuretext, node: node, action: action, onEditingComplete: onEditingComplete)
                Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _symptom,
                decoration: InputDecoration(
                  labelText: 'Enter Symptoms',
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () async {
                int index = SymptomsDataList.length;
                if (flag == true) {
                  final result = SymptomsModelClass(MasterSymptom: _symptom.text);
                  print('object ${result.MasterSymptom}');
                  final DatabaseHelper _databaseService =
                      DatabaseHelper.instance;
                  final saved = await _databaseService.insertInto(
                    result.toJson(),
                    "SymptomMaster",
                  );
                }
                
                print(selectedSymptomValue);
                getMasterSymptomId(selectedSymptomValue ?? '');
                _symptom.text = '';
                print('list is $SymptomsDataList');
              },
              child: Text('Submit')),
        ]));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  getMasterSymptomId(String name) async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    final saved = await _databaseService.symptomId("SymptomMaster", name);
    print("data saved ${saved}");
    selectedSymptomId = saved;
    print('Id selected is $selectedSymptomId');
  }

  insertData() async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;
    await _databaseService.symptomData();
  }

  fetchData() async {
    final DatabaseHelper _databaseService = DatabaseHelper.instance;

    final res = await _databaseService.queryAllRows("SymptomMaster");
    res.forEach((element) {
      element.entries.forEach((e) {
        SymptomsDataList.add(e.value.toString());
      });
    });

    print('object ${SymptomsDataList}');
    if (SymptomsDataList.length == 0) {
      insertData();
      print('entered');
      final res = await _databaseService.queryAllRows("SymptomMaster");
      res.forEach((element) {
        element.entries.forEach((e) {
          SymptomsDataList.add(e.value.toString());
        });
      });
      int index = SymptomsDataList.length;
      print(index);
      SymptomsDataList.add('Others');
      // SymptomsDataList.insert((index), 'Others');
      print('Hello');
      print('list is $SymptomsDataList');
      return SymptomsDataList;
    } else {
      print('Feed me more');
      return SymptomsDataList;
    }
  }
}
