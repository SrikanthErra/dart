import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:side_menu/modelClasses/prescription_list_model.dart';

import 'Reusable/app_input_text.dart';

class prescriptionList extends StatefulWidget {
  const prescriptionList({super.key});

  @override
  State<prescriptionList> createState() => _prescriptionListState();
}

class _prescriptionListState extends State<prescriptionList> {
  List<prescriptionListModel> prescList = [];
  String? DoctorName;
  String? PrescriptionDate;
  String? MedicineName;
  String? Symptoms;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(title: Text('Prescription List'), centerTitle: true),
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
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppInputText(
                text: 'Family Member Name',
                colors: Colors.white,
                size: 15,
                weight: FontWeight.bold),
            ListView.builder(
              shrinkWrap: true,
              itemCount: prescList.length,
              itemBuilder: (context, index) {
                final prescriptionlist = prescList[index];
                DoctorName = prescriptionlist.doctorName;
                PrescriptionDate = prescriptionlist.prescriptionDate;
                MedicineName = prescriptionlist.medicineName;
                Symptoms = prescriptionlist.symptoms;
                return Container(
                  child: Card(
                  
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors.black87, width: 1),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Column(
                                    children: [
                                      RowComponent(
                                        "Doctor Name",
                                        prescriptionlist.doctorName,
                                      ),
                                      RowComponent(
                                        "Prescription Date",
                                        prescriptionlist.prescriptionDate,
                                      ),
                                      RowComponent(
                                        "Medicine Name",
                                        prescriptionlist.medicineName,
                                      ),
                                      RowComponent(
                                        "Symptoms",
                                        prescriptionlist.symptoms,
                                      ),
                                    
                                    ],
                                  ),
                                ),
                              ),
                 /*  child: Card(
                    // margin: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppInputText(
                                text: 'Doctor Name',
                                colors: Colors.black,
                                size: 14,
                                weight: FontWeight.normal),
                          ),
                          Expanded(
                            child: AppInputText(
                                text: 'Prescription Date',
                                colors: Colors.black,
                                size: 14,
                                weight: FontWeight.normal),
                          ),
                          Expanded(
                            child: AppInputText(
                                text: 'Medicine Name',
                                colors: Colors.black,
                                size: 14,
                                weight: FontWeight.normal),
                          ),
                          Expanded(
                            child: AppInputText(
                                text: 'Symptoms',
                                colors: Colors.black,
                                size: 14,
                                weight: FontWeight.normal),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: AppInputText(
                                text: DoctorName ?? "",
                                colors: Colors.black,
                                size: 14,
                                weight: FontWeight.normal),
                          ),
                          Expanded(
                            child: AppInputText(
                                text: PrescriptionDate ?? "",
                                colors: Colors.black,
                                size: 14,
                                weight: FontWeight.normal),
                          ),
                          Expanded(
                            child: AppInputText(
                                text: MedicineName ?? "",
                                colors: Colors.black,
                                size: 14,
                                weight: FontWeight.normal),
                          ),
                          Expanded(
                            child: AppInputText(
                                text: Symptoms ?? "",
                                colors: Colors.black,
                                size: 14,
                                weight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                 */);
              },
            ),
          ],
        )),
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

  void initState() {
    super.initState();
    fetchNextVisitData();
  }

  fetchNextVisitData() {
    prescList = [
      prescriptionListModel(
          doctorName: "VPsycho Hospital",
          prescriptionDate: "30/12/2022",
          medicineName: 'Sugar',
          symptoms: 'Fever,Itching'),
      prescriptionListModel(
          doctorName: "VPsycho Hospital",
          prescriptionDate: "30/12/2022",
          medicineName: 'Sugar',
          symptoms: 'Fever,Itching'),
      prescriptionListModel(
          doctorName: "VPsycho Hospital",
          prescriptionDate: "30/12/2022",
          medicineName: 'Sugar',
          symptoms: 'Fever,Itching'),
    ];
  }
}
