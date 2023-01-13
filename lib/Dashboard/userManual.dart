import 'package:flutter/material.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../Constants/TextStyles.dart';
import '../Constants/assetsPath.dart';

class UserManual extends StatefulWidget {
  const UserManual({super.key});

  @override
  State<UserManual> createState() => _UserManualState();
}

class _UserManualState extends State<UserManual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Image.asset(
        AssetPath.footer,
        width: double.infinity,
        height: 40,
      ),
      appBar: AppBar(
        title: Text(
          strings.UserManualTitle,
          style: subHeaderStyle,
        ),
        centerTitle: true,
        //backgroundColor: Color.fromARGB(0, 21, 91, 110),
      ),
      body: SfPdfViewer.asset(
        'assets/UserManualSample.pdf',
      ),
    );
  }
}
