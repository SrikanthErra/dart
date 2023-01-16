import 'package:flutter/material.dart';
import 'package:medicineinventory/Constants/appColor.dart';

class WarningAlert extends StatefulWidget {
  final String title, descriptions, Buttontext1, Buttontext2;
  final Image img;
  final Color? Button1bgColor;
  final Color? Button2bgColor;
  final void Function()? onButton1Pressed;
  final void Function()? onButton2Pressed;

  const WarningAlert({
    Key? key,
    required this.title,
    required this.descriptions,
    required this.Buttontext1,
    required this.Buttontext2,
    required this.img,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    this.Button1bgColor,
    this.Button2bgColor,
  }) : super(key: key);

  @override
  _WarningAlertState createState() => _WarningAlertState();
}

class _WarningAlertState extends State<WarningAlert> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(80, 35)),
                        backgroundColor: MaterialStateProperty.all(
                            widget.Button1bgColor ?? AppColors.navy)),
                    onPressed: widget.onButton1Pressed,
                    child: Text(
                      widget.Buttontext1,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(80, 35)),
                        backgroundColor: MaterialStateProperty.all(
                            widget.Button2bgColor ?? AppColors.navy)),
                    onPressed: widget.onButton2Pressed,
                    child: Text(
                      widget.Buttontext2,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: AppColors.navy,
            radius: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: widget.img,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
