import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:side_menu/Constants/StringConstants.dart';
import 'package:side_menu/Constants/assetsPath.dart';
import 'package:side_menu/Reusable/app_input_textfield.dart';
import 'package:side_menu/Reusable/date_picker.dart';
import '../Constants/urlConstant.dart';

class viewPrescription extends StatefulWidget {
  const viewPrescription({super.key});

  @override
  State<viewPrescription> createState() => _viewPrescriptionState();
}

class _viewPrescriptionState extends State<viewPrescription> {
  TextEditingController _famName = TextEditingController();
  TextEditingController _medicineName = TextEditingController();
  TextEditingController _symptom = TextEditingController();
  TextEditingController _expiryDate = TextEditingController();
  TextEditingController _hospitalName = TextEditingController();
  TextEditingController _appointment = TextEditingController();
  TextEditingController _doctorName = TextEditingController();
  TextEditingController _reason = TextEditingController();
  TextEditingController _next = TextEditingController();
  FocusScopeNode _node = FocusScopeNode();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final _formkey3 = GlobalKey<FormState>();
  final _formkey4 = GlobalKey<FormState>();
  List<PlatformFile> files_list = [];
  FilePickerResult? result;

  dynamic placeholder = NetworkImage(UrlConstants.PlaceHolderUrl);

  //File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(strings.PrescView_FamName),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.Background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                AppInputTextfield(
                    hintText: strings.Symptoms,
                    nameController: _symptom,
                    errorMessage: strings.CombinedDropDown_Hint,
                    input_type: TextInputType.text,
                    obsecuretext: false,
                    node: _node,
                    action: TextInputAction.next,
                    onEditingComplete: () {
                      _node.nextFocus();
                    },
                    globalKey: _formkey1),
                AppInputTextfield(
                    hintText: strings.Med_MedName,
                    nameController: _medicineName,
                    errorMessage: strings.MedAlert_errorMedName,
                    input_type: TextInputType.text,
                    obsecuretext: false,
                    node: _node,
                    action: TextInputAction.next,
                    onEditingComplete: () {
                      _node.nextFocus();
                    },
                    globalKey: _formkey2),
                datePickerComponent(
                    hintText: strings.Med_ExpDate,
                    nameController: _expiryDate,
                    errorMessage: strings.MedAlert_errorExpDate,
                    obsecuretext: false,
                    node: _node,
                    action: TextInputAction.next,
                    onEditingComplete: () {
                      _node.nextFocus();
                    },
                    globalKey: _formkey3),
              ],
            ),
            AppInputTextfield(
              hintText: strings.Presc_Hint_hospName,
              nameController: _hospitalName,
              errorMessage: strings.Presc_error_hospName,
              input_type: TextInputType.text,
              obsecuretext: false,
              node: _node,
              action: TextInputAction.next,
              onEditingComplete: () {
                _node.nextFocus();
              },
            ),
            datePickerComponent(
              hintText: strings.Presc_Hint_AppointmentDate,
              nameController: _appointment,
              errorMessage: strings.Presc_error_AppointmentDate,
              obsecuretext: false,
              node: _node,
              action: TextInputAction.next,
              onEditingComplete: () {
                _node.nextFocus();
              },
            ),
            AppInputTextfield(
              hintText: strings.Presc_Hint_DrName,
              nameController: _doctorName,
              errorMessage: strings.Presc_error_DrName,
              input_type: TextInputType.text,
              obsecuretext: false,
              node: _node,
              action: TextInputAction.next,
              onEditingComplete: () {
                _node.nextFocus();
              },
            ),
            AppInputTextfield(
              hintText: strings.Presc_Hint_AppointmentReason,
              nameController: _reason,
              errorMessage: strings.Presc_error_AppointmentReason,
              input_type: TextInputType.text,
              obsecuretext: false,
              node: _node,
              action: TextInputAction.next,
              onEditingComplete: () {
                _node.nextFocus();
              },
            ),
            datePickerComponent(
              hintText: strings.Presc_Hint_NextAppointmentDate,
              nameController: _expiryDate,
              errorMessage: strings.Presc_error_NextAppointmentDate,
              obsecuretext: false,
              node: _node,
              action: TextInputAction.next,
              onEditingComplete: () {
                _node.nextFocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}
