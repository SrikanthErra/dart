import 'dart:io';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:side_menu/app_constants.dart';

class ImgPickerCamera extends StatefulWidget {
  const ImgPickerCamera({super.key, required this.callbackValue});

  final void Function(XFile) callbackValue;

  @override
  State<ImgPickerCamera> createState() => _ImagePickerCameraState();
}

class _ImagePickerCameraState extends State<ImgPickerCamera> {
  final genderList = [
    "Choose from Gallery",
    "Take Photo",
    "Choose Document",
    "cancel"
  ];
  File? _image;
  String? value;
  String? selected;
  Future getImage(ImageSource type) async {
    final XFile? img = await ImagePicker().pickImage(source: type);
    setState(() {
      _image = File(img!.path);
      this.widget.callbackValue(img);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        _image != null
            ? Image.file(
                _image!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue,
                  ),
                  child: IconButton(
                    onPressed: (() {
                      showAlert("Add Photo");
                    }),
                    icon: Icon(Icons.camera_alt_outlined),
                    color: Colors.white,
                  ),
                ),
              ),
        /* _image != null
            ? GestureDetector(
                onTap: () async {
                  await getImage(ImageSource.camera);
                },
                child: Image.file(
                  _image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )
            : GestureDetector(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                child: Icon(
                  Icons.camera_outlined,
                  size: 50,
                ),
              ) */
      ],
    );
  }

  showAlert(String message, {String text = ""}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 45, 88, 124),
            title: Center(
              child: Text(message,style: TextStyle(color: Colors.amber),)
               /* TextWidget(
                text: message + text,
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                fontsize: 15,
                textcolor: Colors.white,
              ), */
            ),

            // title: Text(message + text),
            actions: [
              /* ValueListenableBuilder(
                valueListenable: userGender,
                builder: (context, value, child) { */
                   RadioGroup<String>.builder(
                    textStyle: TextStyle(color: Colors.white),
                    groupValue: value ?? "",
                    onChanged: (value) {
                      AppConstants.selected = value;
                      if (value == "Choose Document") {
                        getImage(ImageSource.gallery);
                      } else if (value == "Take Photo") {
                        getImage(ImageSource.camera);
                      } else if (value == "Choose from Gallery") {
                        getImage(ImageSource.gallery);
                      } else if (value == "cancel") {
                        // Navigator.pop(context);
                      }
                      Navigator.pop(context);
                    },
                    items: genderList,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  )
                /* },
              ), */
            ],
          );
        });
    //showDialog
  }
}