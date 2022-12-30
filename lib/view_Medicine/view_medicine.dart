import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_menu/modelClasses/view_medicine_model.dart';
import '../Database/database_helper.dart';
import '../Reusable/app_input_text.dart';
import '../modelClasses/database_modelClass/medicationModel.dart';

class viewMedicine extends StatefulWidget {
  const viewMedicine({super.key});

  @override
  State<viewMedicine> createState() => _viewMedicineState();
}

class _viewMedicineState extends State<viewMedicine> {
  List<viewMedicineModel> viewMedList = [];
  List<viewMedicineModel> viewSearchMedList = [];
  String? MedName;
  String? ExpDate;
  String? symptom;
  int? TabletsCount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* WidgetsBinding.instance.addPostFrameCallback((callback) {
      fetchdata();
    }); */
    /* WidgetsBinding.instance.addPostFrameCallback((_) async {
     
    }); */
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    //MedList = ModalRoute.of(context)?.settings.arguments as dynamic;
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white),

                  //cursorHeight: 10,
                  //  TextStyle(color: Colors.white),
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "Search Symptom/MedicineName",
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AppInputText(
                    text: 'MedicinesList',
                    colors: Colors.white,
                    size: 15,
                    weight: FontWeight.bold),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: viewSearchMedList.length,
                itemBuilder: (context, index) {
                  final MedicineList = viewSearchMedList[index];
                  MedName = MedicineList.MedicineName;
                  ExpDate = MedicineList.ExpiryDate;
                  symptom = MedicineList.Symptom;
                  TabletsCount = MedicineList.TabletsCount;
                  //  SymId = MedicineList.SymptomId;
                  return Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black87, width: 1),
                      ),
                      color: Colors.white,
                      child: Column(
                        children: [
                          RowComponent("Symptom", symptom),
                          RowComponent(
                            "Medicine Name",
                            MedName,
                          ),
                          RowComponent(
                            "Tablets Count",
                            TabletsCount,
                          ),
                          RowComponent("Expiry Date", ExpDate),
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

  fetchdata() async {
    await DatabaseHelper.instance.viewMed().then((value) {
      setState(() {
        viewMedList = [];
        value.forEach((element) {
          print('element is $element');
          viewMedList.add(viewMedicineModel(
            Symptom: element["Symptom"],
            MedicineName: element["MedicineName"],
            TabletsCount: element["TabletsCount"],
            ExpiryDate: element["ExpiryDate"],
            /*  ExpiryDate: element["ExpiryDate"],
            MedicineName: element["MedicineName"],
            MedicinePhoto: element["MedicinePhoto"], */
          ));
          print(' id ${viewMedList}');
          viewSearchMedList = viewMedList;
        });
      });
    });
  }

  _runFilter(String enteredKeyword) {
    List<viewMedicineModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = viewMedList;
    } else {
      print(enteredKeyword);
      results = viewMedList
          .where((element) =>
              element.Symptom!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.MedicineName!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      viewSearchMedList = results;
      print(viewSearchMedList.length);
    });
  }
}
