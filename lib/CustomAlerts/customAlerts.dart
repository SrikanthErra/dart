import 'package:flutter/material.dart';
import 'package:medicineinventory/Constants/appColor.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, Buttontext;
  final Image img;
  final Color? bgColor;
  final void Function()? onPressed;

  const CustomDialogBox({
    Key? key,
    required this.title,
    required this.descriptions,
    required this.Buttontext,
    required this.img,
    required this.onPressed,
    this.bgColor,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(220, 50)),
                        backgroundColor: MaterialStateProperty.all(
                            widget.bgColor ?? AppColors.navy)),
                    onPressed: widget.onPressed,
                    child: Text(
                      widget.Buttontext,
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: widget.bgColor ?? AppColors.navy,
            radius: 30,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: widget.img),
          ),
        ),
      ],
    );
  }
}
