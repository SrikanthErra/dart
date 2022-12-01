import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlertTextField extends StatelessWidget {
  const AlertTextField({
    super.key,
    required this.hintText,
    required this.nameController,
    required this.errorMessage,
    required this.input_type,
    required this.obsecuretext,
    required this.node,
    required this.action,
    required this.onEditingComplete,
    this.globalKey,
    this.prefixIcon,
    // this.isSecured,
    // this.isVisible,
    this.onTap,
    this.suffixIcon,
    this.onChanged,
  });
  final String hintText, errorMessage;
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
            style: const TextStyle(color: Colors.black),
            controller: nameController,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: prefixIcon,
              //suffixIcon: null == suffixIcon ? null : Icon(suffixIcon),
              suffixIcon: suffixIcon,

              /* this.isSecured == true
                  ? GestureDetector(
                      onTap: () {
                        this.onTap!();
                      },
                      child: Icon(this.isVisible == true
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )
                  : null, */
              //prefixIcon: Icon(Icons.people),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelStyle: TextStyle(
                color: Colors.black,
                // color: node.hasFocus?Colors.amber:Colors.blue,
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
        ),
      ),
    );
  }
}
