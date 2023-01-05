import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppInputText extends StatelessWidget {
  const AppInputText(
      {super.key,
      required this.text,
      required this.colors,
      required this.size,
      required this.weight
      // required this.fontsize
      });
  final String text;
  final Color colors;
  final double size;
  final FontWeight weight;
  //final FontWeight fontsize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(color: colors, fontSize: size, fontWeight: weight),
      ),
    );
  }
}

/*Text(
    "Your text",
     style: TextStyle(
      fontSize: 20.0,
      color: Colors.red,
      fontWeight: FontWeight.w600,
    ),
  )*/