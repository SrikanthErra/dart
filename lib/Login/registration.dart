import 'package:flutter/material.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:medicineinventory/Constants/assetsPath.dart';
import 'package:medicineinventory/Reusable/app_input_text.dart';
import 'package:medicineinventory/Reusable/app_input_textfield.dart';
import 'package:medicineinventory/Reusable/button_component.dart';
import 'package:medicineinventory/Reusable/toast.dart';
import 'package:medicineinventory/Routes/App_routes.dart';
import 'package:medicineinventory/Constants/app_constants.dart';
import 'package:medicineinventory/modelClasses/registration_familyList_model.dart';

import '../Constants/TextStyles.dart';
import '../CustomAlerts/customAlerts.dart';

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
  List Gender = [
    strings.Gender_Male,
    strings.Gender_Female,
    strings.Gender_Other
  ];
  late String select;

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
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Center(child: Text(strings.RegFamMem))),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.Background),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50, backgroundImage: AssetImage(AssetPath.AppLogo)),
              AppInputText(
                text: strings.Registration,
                colors: Colors.white,
                size: 30,
                weight: FontWeight.w600,
              ),
              AppInputTextfield(
                hintText: strings.RegFam_Hint_FamMemName,
                nameController: _family_name,
                errorMessage: strings.RegFam_ErrorMsg_Name,
                input_type: TextInputType.text,
                obsecuretext: false,
                action: TextInputAction.next,
                node: _node,
                onEditingComplete: () {
                  _node.nextFocus();
                },
                globalKey: _formkey1,
              ),
              AppInputTextfield(
                hintText: strings.RegFam_Hint_Age,
                nameController: _age,
                errorMessage: strings.RegFam_ErrorMsg_Age,
                input_type: TextInputType.number,
                obsecuretext: false,
                action: TextInputAction.next,
                node: _node,
                onEditingComplete: () {
                  _node.nextFocus();
                },
                globalKey: _formkey2,
              ),

              //AppMultiSelect(node: _node),
              //MultiselectDropdown(),

              AppInputTextfield(
                hintText: strings.RegFam_Hint_Mobile,
                nameController: _mobileNumber,
                errorMessage: strings.RegFam_ErrorMsg_Mobile,
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
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        strings.Gender_SelectHeader,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            addRadioButton(0, strings.Gender_Male),
                            addRadioButton(1, strings.Gender_Female),
                            addRadioButton(2, strings.Gender_Other),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ButtonComponent(
                  onPressed: () async {
                    if (_formkey1.currentState!.validate() &&
                        _formkey2.currentState!.validate() &&
                        _formkey3.currentState!.validate() &&
                        selectedValue != null &&
                        (_mobileNumber.text.length == 10)) {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.mpinPage,
                          arguments: registrationFamilyModel(
                            name: _family_name.text,
                            age: _age.text,
                            mobile: _mobileNumber.text,
                            gender: selectedValue,
                          ));
                      //getDropDownItem();
                    } else if (_formkey1.currentState!.validate() &&
                        _formkey2.currentState!.validate() &&
                        _formkey3.currentState!.validate() &&
                        (_mobileNumber.text.length < 10 ||
                            _mobileNumber.text.length > 10)) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            title: "MOBILE NUMBER INVALID",
                            descriptions: strings.MobileAlert,
                            Buttontext: 'OK',
                            img: Image.asset(AssetPath.WarningBlueIcon),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    } else if (selectedValue == null) {
                      showToast(strings.GenderText);
                    }
                    print(AppConstants.symptomsList);
                  },
                  buttonText: strings.ButtonSubmit),
            ],
          ),
        ),
      ),
    );
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      children: <Widget>[
        Radio(
          activeColor: Colors.white,
          value: Gender[btnValue],
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              print(value);
              selectedValue = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: RadioTextSTyle,
          ),
        )
      ],
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
