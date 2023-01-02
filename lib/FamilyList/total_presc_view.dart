import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../Reusable/app_input_text.dart';
import '../modelClasses/total_presc_view_model.dart';

class totalPrescView extends StatefulWidget {
  const totalPrescView({super.key});

  @override
  State<totalPrescView> createState() => _totalPrescViewState();
}

class _totalPrescViewState extends State<totalPrescView> {
  List<totalPrescViewModel> totalPresc = [];
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    totalPresc = ModalRoute.of(context)?.settings.arguments as dynamic;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
                            RowComponent(
                                "MedicinePhoto", totalPrescList.MedicinePhoto),
                            RowComponent(
                                "PrescFiles", totalPrescList.PrescFiles),

                            //print(""+totalPrescList.MedicinePhoto);

                            /*  Image.file(
                              File.fromUri(
                                  Uri.parse(totalPrescList.MedicinePhoto!)),
                              width: 100,
                              height: 100,
                            ), */

                            /*  Image.file(
                        File(wrestler.image ?? ""),
                        width: 100,
                        height: 100,
                      ), */
                            Image.file(File(totalPrescList.MedicinePhoto ?? ''),
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: MediaQuery.of(context).size.height * 0.2
                                /* width: 100,
                              height: 100, */
                                ),

                                Image.file(File(totalPrescList.PrescFiles ?? ''),
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: MediaQuery.of(context).size.height * 0.2
                                /* width: 100,
                              height: 100, */
                                ), 
                                /*
                                Visibility(
                      visible: vis ?? false,
                      child: Card(
                        color: Colors.transparent,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: Uploadedfiles.length,
                            itemBuilder: ((context, index) {
                              print('Hello world');
                              final res = Uploadedfiles[index];
                              /*  final details3 = PrescriptionStateProvider
                                  .prescFiles[index].PrescFilesList!; */
                              return ListTile(
                                  leading: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: 100,
                                      minHeight: 260,
                                      maxWidth: 104,
                                      maxHeight: 264,
                                    ),
                                    child: (res?.path.split('.').last == 'jpg' ||
                                            res?.path.split('.').last == 'png')
                                        ? Image.file(
                                            File(res?.path.toString() ?? ''),
                                            width: 100,
                                            height: 100,
                                          )
                                        : SvgPicture.asset(
                                            'assets/pdf.svg',
                                            /* height: 30,
                                                        width: 30, */
                                            //  color: Colors.white,
                                          ),
                                  ),
                                  onTap: () {
                                    AppConstants.filePath = res?.path.toString() ?? '';
                                    print(AppConstants.filePath);
                                    Navigator.pushNamed(
                                        context, AppRoutes.pdfViewer);
                                  }
                                  //  child: PdfView(path: fileName.path),

                                  //       SfPdfViewer.file(
                                  // File('storage/emulated/0/Download/flutter-succinctly.pdf')));

                                  );
                            })),
                      ),
                    ),
                                */
                            // FileImage(File(totalPrescList.MedicinePhoto ?? ''))
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Image.file(File(totalPrescList.MedicinePhoto!),
                            //   width: 100,
                            //   height: 100,),
                            // ),
                            /*  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(totalPrescList.MedicinePhoto!
                                  /* width: 100,
                                  height: 100, */),
                                ), */
                            /* Image.network(
                                'https://www.gstatic.com/webp/gallery/1.jpg') */
                            //  new Io.File.fromUri(imageFile.uri)
                          ],
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
}
