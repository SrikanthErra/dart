import 'package:flutter/material.dart';

class containerComponent extends StatelessWidget {
  const containerComponent(
      {super.key,
      required this.containerText,
      required this.containercolors,
      required this.textcolor,
      required this.size,
      required this.weight,
      required this.textalign,
      required this.routeName});
  final Color containercolors, textcolor;
  final String containerText;
  final double size;
  final FontWeight weight;
  final TextAlign textalign;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        margin: EdgeInsets.only(top: 40, left: 60),
        height: 150,
        width: 120,
        decoration: BoxDecoration(
            color: containercolors, borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(containerText,
                style: TextStyle(
                  color: textcolor,
                  fontSize: size,
                  fontWeight: weight,
                ),
                textAlign: textalign)),
      ),
    );
  }
}
