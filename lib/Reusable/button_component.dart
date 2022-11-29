import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent(
      {super.key, required this.onPressed, required this.buttonText});
  final void Function()? onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 326,
        height: 50,
        child: ElevatedButton(
          onPressed: this.onPressed!,
          child: Text(buttonText),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(vertical: 12.0),
    );
  }
}
