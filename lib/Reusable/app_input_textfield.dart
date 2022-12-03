import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppInputTextfield extends StatelessWidget {

  final String hintText, errorMessage;
  final TextEditingController nameController;
  final TextInputType input_type;
  final bool obsecuretext;
  final FocusScopeNode node;
  final TextInputAction action;
  final VoidCallback? onEditingComplete;
  final GlobalKey? globalKey;
  final int? length;
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
            maxLength: length,
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
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white)),
              labelStyle: TextStyle(
                color: Colors.white,
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
