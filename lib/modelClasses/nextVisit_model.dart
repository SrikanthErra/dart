import 'package:image_picker/image_picker.dart';

class NextVisitModel {
  String? HospitalName;
  String? ReasonForAppointment;
  String? NextAppointmentDate;

  NextVisitModel(
      {
      this.HospitalName,
      this.ReasonForAppointment,
      this.NextAppointmentDate,});

  NextVisitModel.fromJson(Map<String, dynamic> json) {
    HospitalName = json['HospitalName'];
    ReasonForAppointment = json['ReasonForAppointment'];
    NextAppointmentDate = json['NextAppointmentDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HospitalName'] = this.HospitalName;
    data['ReasonForAppointment'] = this.ReasonForAppointment;
    data['NextAppointmentDate'] = this.NextAppointmentDate;
    return data;
  }
}
