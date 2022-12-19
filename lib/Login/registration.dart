import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_group_button/flutter_group_button.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:side_menu/Reusable/app_input_text.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/app_multiselect.dart';
import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Routes/App_routes.dart';
import 'package:side_menu/app_constants.dart';
import 'package:side_menu/modelClasses/registration_familyList_model.dart';
import 'package:side_menu/Reusable/button_component.dart';
import 'package:side_menu/Database/database_helper.dart';

class registerFamily extends StatefulWidget {
  const registerFamily({super.key});

  @override
  State<registerFamily> createState() => _registerFamilyState();
}
/* class Animal {
  final int? id;
  final String? name;

  Animal({
    this.id,
    this.name,
  });
} */

class _registerFamilyState extends State<registerFamily> {
  TextEditingController _family_name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _mobileNumber = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  //List<String> _gender = ["Male", "Female", "Others"];
  String? gender;

  //String holder = '';
  bool value = false;
  String? selectedValue;
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formkey3 = GlobalKey<FormState>();
  /* void getDropDownItem() {
    setState(() {
      holder = selectedValue ?? "";
    });
  } */
  /* static List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
    Animal(id: 8, name: "Snake"),
    Animal(id: 9, name: "Bear"),
    Animal(id: 10, name: "Others"),
   
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name ?? ''))
      .toList(); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Center(child: Text('Register a Family'))),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/appLogo.png")),
              AppInputText(
                text: 'Registration',
                colors: Colors.white,
                size: 30,
                weight: FontWeight.w600,
              ),
              AppInputTextfield(
                hintText: 'Name of family Member',
                nameController: _family_name,
                errorMessage: 'please enter name',
                input_type: TextInputType.text,
                obsecuretext: false,
                action: TextInputAction.next,
                node: _node,
                onEditingComplete: () {
                  _node.nextFocus();
                },
                globalKey: _formkey1,
              ),
              AppMultiSelect(node: _node),
              /* MultiSelectDialogField(
               // searchHint: 
                items: _items,
                title: Text("Animals",),
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.pets,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  "Favorite Animals",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  //_selectedAnimals = results;
                },
              ), */
              AppInputTextfield(
                hintText: 'Age',
                nameController: _age,
                errorMessage: 'please enter age',
                input_type: TextInputType.number,
                obsecuretext: false,
                action: TextInputAction.next,
                node: _node,
                onEditingComplete: () {
                  _node.nextFocus();
                },
                globalKey: _formkey2,
              ),
              AppInputTextfield(
                hintText: 'Mobile Number',
                nameController: _mobileNumber,
                errorMessage: 'please enter Mobile number',
                input_type: TextInputType.number,
                obsecuretext: false,
                action: TextInputAction.next,
                node: _node,
                onEditingComplete: () {
                  _node.nextFocus();
                },
                length: 10,
                globalKey: _formkey3,
              ),
              /* RadioGroup(
                  children: [
                    AppInputText(
                        text: 'Male',
                        colors: Colors.white,
                        size: 15,
                        weight: FontWeight.normal),
                    AppInputText(
                        text: 'Female',
                        colors: Colors.white,
                        size: 15,
                        weight: FontWeight.normal),
                    AppInputText(
                        text: 'Others',
                        colors: Colors.white,
                        size: 15,
                        weight: FontWeight.normal)
                  ],
                  groupItemsAlignment: GroupItemsAlignment.row,
                  mainAxisAlignment: MainAxisAlignment.start,
                  internMainAxisAlignment: MainAxisAlignment.start,

                  /// In reality this is not needed
                  // priority: RadioPriority.textBeforeRadio,
                  defaultSelectedItem: -1,
                  onSelectionChanged: (selection) {
                    print(selection);
                  }), */
              Text(
                "Select Gender:",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              RadioListTile(
                // contentPadding: EdgeInsets.zero,
                title: Text(
                  "Male",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                value: "male",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),
              RadioListTile(
                //contentPadding: EdgeInsets.zero,
                title: Text(
                  "Female",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                value: "female",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),
              RadioListTile(
                //contentPadding: EdgeInsets.zero,
                title: Text(
                  "Other",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                value: "other",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),
              ButtonComponent(
                  onPressed: () async {
                    if (_formkey1.currentState!.validate() &&
                        _formkey2.currentState!.validate() &&
                        _formkey3.currentState!.validate()) {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.mpinPage,
                          arguments: registrationFamilyModel(
                              name: _family_name.text,
                              age: _age.text,
                              mobile: _mobileNumber.text,
                              gender: gender));
                      //getDropDownItem();
                    }
                    print(AppConstants.symptomsList);
                  },
                  buttonText: 'Submit'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _node.dispose();
    super.dispose();
  }
}
