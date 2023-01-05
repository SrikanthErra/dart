import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class datePickerComponent extends StatelessWidget {
  const datePickerComponent(
      {super.key,
      required this.hintText,
      required this.nameController,
      required this.errorMessage,
      this.input_type,
      required this.obsecuretext,
      required this.node,
      required this.action,
      required this.onEditingComplete,
      this.globalKey,
      this.prefixIcon,
      // this.isSecured,
      // this.isVisible,
      this.onTap,
      this.suffixIcon});
  final String hintText, errorMessage;
  final TextEditingController nameController;
  final TextInputType? input_type;
  final bool obsecuretext;
  final FocusScopeNode node;
  final TextInputAction action;
  final VoidCallback? onEditingComplete;
  final GlobalKey? globalKey;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  // final IconData? suffixIcon;
  // final bool? isSecured;
  // final bool? isVisible;

  final void Function()? onTap;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FocusScope(
        node: node,
        child: Form(
          key: globalKey,
          child: TextFormField(
            obscureText: obsecuretext,
            textInputAction: action,
            onEditingComplete: onEditingComplete,
            style: const TextStyle(color: Colors.white),
            controller: nameController,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: prefixIcon,
              //suffixIcon: null == suffixIcon ? null : Icon(suffixIcon),
              suffixIcon: suffixIcon,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              labelText: hintText,
            ),
            onTap: () async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2025),
    ).then((selectedDate) {
      if (selectedDate != null) {
        nameController.text =
            DateFormat('dd-MM-yyyy').format(selectedDate);
      }
    });
  },
            validator: (value) {
              if (value!.isEmpty) {
                return errorMessage;
              }
            },
            keyboardType: input_type,
          ),
        ),
      ),
    );
  }
}

/* import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class datePicker extends StatelessWidget {
  const datePicker({super.key, required this.nameController});
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
  readOnly: true,
  controller: nameController,
  decoration: InputDecoration(
    labelText: 'Date',
  ),
  /* onTap: () async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2025),
    ).then((selectedDate) {
      if (selectedDate != null) {
        nameController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }, */
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter date.';
    }
    return null;
  },
);
  }
} */