import 'package:image_picker/image_picker.dart';

class PrescriptionModel {
  int? SymptomId;
  int? SId;
  int? FamilyMemberId;
  String? Symptom;
  String? DoctorName;
  String? HospitalName;
  String? DateOfAppointment;
  String? ReasonForAppointment;
  String? NextAppointmentDate;
  String? PrescFiles;

  PrescriptionModel(
      {this.SymptomId,
      this.SId,
      this.FamilyMemberId,
      this.Symptom,
      this.DoctorName,
      this.HospitalName,
      this.DateOfAppointment,
      this.ReasonForAppointment,
      this.NextAppointmentDate,
      this.PrescFiles});

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    SymptomId = json['SymptomId'];
    Symptom = json['Symptom'];
    SId = json['SId'];
    FamilyMemberId = json['FamilyMemberId'];
    DoctorName = json['DoctorName'];
    HospitalName = json['HospitalName'];
    DateOfAppointment = json['DateOfAppointment'];
    ReasonForAppointment = json['ReasonForAppointment'];
    NextAppointmentDate = json['NextAppointmentDate'];
    PrescFiles = json['PrescFiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SymptomId'] = this.SymptomId;
    data['SId'] = this.SId;
    data['FamilyMemberId'] = this.FamilyMemberId;
    data['Symptom'] = this.Symptom;
    data['DoctorName'] = this.DoctorName;
    data['HospitalName'] = this.HospitalName;
    data['DateOfAppointment'] = this.DateOfAppointment;
    data['ReasonForAppointment'] = this.ReasonForAppointment;
    data['NextAppointmentDate'] = this.NextAppointmentDate;
    data['PrescFiles'] = this.PrescFiles;
    return data;
  }
}
