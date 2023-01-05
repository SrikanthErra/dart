import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_menu/Constants/StringConstants.dart';
import 'package:side_menu/Constants/TextStyles.dart';
import 'package:side_menu/Constants/assetsPath.dart';
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
      appBar: AppBar(title: Text(strings.TotPrescTitle), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.Background),
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
                    text: strings.TotPrescHeader,
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
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            children: [
                              RowComponent(
                                  strings.Profile_FamName, totalPrescList.name),
                              RowComponent(
                                  strings.Symptoms, totalPrescList.Symptom),
                              RowComponent(strings.Med_MedName,
                                  totalPrescList.MedicineName),
                              RowComponent(strings.Med_ExpDate,
                                  totalPrescList.ExpiryDate),
                              RowComponent(strings.Presc_Hint_DrName,
                                  totalPrescList.DoctorName),
                              RowComponent(strings.Presc_Hint_hospName,
                                  totalPrescList.HospitalName),
                              RowComponent(strings.Presc_Hint_AppointmentDate,
                                  totalPrescList.DateOfAppointment),
                              RowComponent(strings.Presc_Hint_AppointmentReason,
                                  totalPrescList.ReasonForAppointment),
                              RowComponent(
                                  strings.Presc_Hint_NextAppointmentDate,
                                  totalPrescList.NextAppointmentDate),
                              RowImageComponent(strings.Med_Photo,
                                  totalPrescList.MedicinePhoto ?? ''),
                              RowImageComponent(strings.PrescFileHeader,
                                  totalPrescList.PrescFiles ?? ""),

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
                              /*        Image.file(File(totalPrescList.MedicinePhoto ?? ''),
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  height: MediaQuery.of(context).size.height * 0.2
                                  /* width: 100,
                                height: 100, */
                                  ), */

                              /* Image.file(File(totalPrescList.PrescFiles ?? ''),
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  height: MediaQuery.of(context).size.height * 0.2
                                  /* width: 100,
                                height: 100, */
                                  ), */
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
              style: RowComponentHeaderTextStyle,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: RowComponentTextStyle,
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
              style: RowComponentHeaderTextStyle,
            ),
          ),
          Expanded(
            child: Image.file(File(MedicinePhotoPath),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.2
                /* width: 100,
                              height: 100, */
                ),
          ),
        ],
      ),
    );
  }
}
