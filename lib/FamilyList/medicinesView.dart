import 'package:flutter/material.dart';
import '../Database/database_helper.dart';
import '../Reusable/app_input_text.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({super.key});

  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  List<MedicineModel> MedList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
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
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppInputText(
                  text: 'MedicinesList',
                  colors: Colors.white,
                  size: 15,
                  weight: FontWeight.bold),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: MedList.length,
                itemBuilder: (context, index) {
                  final MedicineList = MedList[index];
                  final MedName = MedicineList.MedicineName;
                  final SymId = MedicineList.SymptomId;
                  return Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black87, width: 1),
                      ),
                      color: Colors.white,
                      child: Column(
                        children: [
                          RowComponent(
                            "Medicine Name",
                            MedName,
                          ),
                          RowComponent(
                            "Symptom ID",
                            SymId,
                          ),
                        ],
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

  void initState() {
    super.initState();
    DatabaseHelper.instance.queryAllRows("Medicines").then((value) {
      setState(() {
        value.forEach((element) {
          MedList.add(
            MedicineModel(
              MedicineName: element["MedicineName"],
              SymptomId: element["SymptomId"],
            ),
          );
        });
      });
    }).catchError((error) {
      print(error);
    });
  }
}
