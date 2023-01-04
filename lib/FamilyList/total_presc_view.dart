import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../Reusable/app_input_text.dart';
import '../Routes/App_routes.dart';
import '../app_constants.dart';
import '../modelClasses/total_presc_view_model.dart';

class totalPrescView extends StatefulWidget {
  const totalPrescView({super.key});

  @override
  State<totalPrescView> createState() => _totalPrescViewState();
}

class _totalPrescViewState extends State<totalPrescView> {
  List<totalPrescViewModel> totalPresc = [];
  List<String>? result;
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    totalPresc = ModalRoute.of(context)?.settings.arguments as dynamic;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text('Total Prescription List'), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        //margin: EdgeInsets.symmetric(vertical: 20),
        height: MediaQuery.of(context).size.height,

        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AppInputText(
                    text: 'Total Prescription view',
                    colors: Colors.white,
                    size: 15,
                    weight: FontWeight.bold),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: totalPresc.length,
                itemBuilder: (context, index) {
                  final totalPrescList = totalPresc[index];
                  //final myString = 'abc=';
                  final files = totalPrescList.PrescFiles?.replaceAll(
                      new RegExp(r'[^\w\s]+'), '');
                  print('files $files');
                  // final input = '[name 1, name2, name3, ...]';
                  final removedBrackets = totalPrescList.PrescFiles?.substring(
                      1, totalPrescList.PrescFiles!.length - 1);

                  print('remove $removedBrackets');
                  result = removedBrackets?.split(',');
                  print('Result is $result');
                  print('len ${result?.length}');
                  /*  final files = totalPrescList.PrescFiles?.replaceAll(
                    RegExp(''),
                  ); */
                  // final hello = File(totalPrescList.MedicinePhoto ?? '');
                  //  SymId = MedicineList.SymptomId;
                  return Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black87, width: 1),
                      ),
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            children: [
                              RowComponent("Name", totalPrescList.name),
                              RowComponent("Symptom", totalPrescList.Symptom),
                              RowComponent(
                                  "Medicine Name", totalPrescList.MedicineName),
                              RowComponent(
                                  "Expiry Date", totalPrescList.ExpiryDate),
                              RowComponent(
                                  "DoctorName", totalPrescList.DoctorName),
                              RowComponent(
                                  "HospitalName", totalPrescList.HospitalName),
                              RowComponent("DateOfAppointment",
                                  totalPrescList.DateOfAppointment),
                              RowComponent("ReasonForAppointment",
                                  totalPrescList.ReasonForAppointment),
                              RowComponent("NextAppointmentDate",
                                  totalPrescList.NextAppointmentDate),
                              RowImageComponent("MedicinePhoto",
                                  totalPrescList.MedicinePhoto ?? ''),
                              /* RowImageComponent("Prescription Files",
                                  totalPrescList.PrescFiles ?? ""), */
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      "Prescription Files",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: result?.length,
                                          itemBuilder: ((context, index) {
                                            print(
                                                'Presc files ${result?.length}');
                                            final res = result?[index];
                                            final array = res?.trim();
                                            return Container(
                                              child: (array?.split('.').last ==
                                                          'jpg' ||
                                                      array?.split('.').last ==
                                                          'png')
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        showImageViewer(
                                                            context,
                                                            Image.file(File(
                                                                    array!))
                                                                .image);
                                                      },
                                                      child: Image.file(
                                                        File(
                                                            array?.toString() ??
                                                                ''),
                                                        width: 100,
                                                        height: 100,
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        AppConstants.filePath =
                                                            array?.toString() ??
                                                                '';
                                                        print(AppConstants
                                                            .filePath);
                                                        Navigator.pushNamed(
                                                            context,
                                                            AppRoutes
                                                                .pdfViewer);
                                                      },
                                                      child: SvgPicture.asset(
                                                          'assets/pdf.svg',
                                                          width: 100,
                                                          height: 100
                                                          //  color: Colors.white,
                                                          ),
                                                    ),
                                            );
                                          }))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  RowComponent(var data, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  RowImageComponent(String title, String MedicinePhotoPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                showImageViewer(
                    context, Image.file(File(MedicinePhotoPath)).image);
              },
              child: Image.file(
                File(MedicinePhotoPath),
                width: 80,
                height: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
