import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:side_menu/app_constants.dart';

class AppMultiSelect extends StatefulWidget {
  const AppMultiSelect({
    super.key,
    required this.node,
    /* required this.hintText,
    required this.nameController,
    required this.errorMessage,
    required this.input_type,
    required this.obsecuretext,
    required this.node,
    required this.action,
    required this.onEditingComplete,
    this.globalKey,
    this.prefixIcon,
    this.onTap,
    this.suffixIcon,
    this.onChanged, */
  });
  final FocusScopeNode node;
  /*  final String hintText, errorMessage;
  final TextEditingController nameController;
  final TextInputType input_type;
  final bool obsecuretext;
  final FocusScopeNode node;
  final TextInputAction action;
  final VoidCallback? onEditingComplete;
  final GlobalKey? globalKey;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final void Function()? onTap; */

  @override
  State<AppMultiSelect> createState() => _AppMultiSelectState();
}

class _AppMultiSelectState extends State<AppMultiSelect> {
  List? _myActivities;

  late String _myActivitiesResult;

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    //super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FocusScope(
        node: widget.node,
        child: /* Form(
          key: globalKey,
          child: TextFormField(
            obscureText: obsecuretext,
            textInputAction: action,
            onEditingComplete: onEditingComplete,
            style: const TextStyle(color: Colors.black),
            controller: nameController,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              labelText: hintText,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return errorMessage;
              }
            },
            keyboardType: input_type,
          ),
        ), */
            Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: AutovalidateMode.disabled,
                  chipBackGroundColor: Colors.blue,
                  chipLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.blue,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  title: Text(
                    "Symptoms",
                    style: TextStyle(fontSize: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                    return null;
                  },
                  dataSource: [
                    {
                      "display": "Fever",
                      "value": "Fever",
                    },
                    {
                      "display": "Cold",
                      "value": "Cold",
                    },
                    {
                      "display": "Cough",
                      "value": "Cough",
                    },
                    {
                      "display": "Headache",
                      "value": "Headache",
                    },
                    {
                      "display": "Stomach ache",
                      "value": "Stomach ache",
                    },
                    {
                      "display": "Body ache",
                      "value": "Body ache",
                    },
                    {
                      "display": "Injury",
                      "value": "Injury",
                    },
                    {
                      "display": "Others",
                      "value": "Others",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text('Please choose one or more'),
                  initialValue: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                      AppConstants.multiselect_formfield = _myActivities ?? [];
                    });
                  },
                ),
              ),
              /* Container(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  child: Text('Save'),
                  onPressed: _saveForm,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(_myActivitiesResult),
              ) */
            ],
          ),
        ),
      ),
    );
  }
}
