class PrescriptionSymptomsModel {
  int? SymptomId;
  String? mobileNumber;
  String? FamilyMemberName;
  String? Symptom;
  String? MedicineName;
  String? DoctorName;
  String? HospitalName;
  String? DateOfAppointment;
  String? ReasonForAppointment;

  PrescriptionSymptomsModel({
    this.SymptomId,
    this.mobileNumber,
    this.FamilyMemberName,
    this.Symptom,
    this.MedicineName,
    this.DoctorName,
    this.HospitalName,
    this.DateOfAppointment,
    this.ReasonForAppointment,
  });

  PrescriptionSymptomsModel.fromJson(Map<String, dynamic> json) {
    SymptomId = json['SymptomId'];
    mobileNumber = json['mobileNumber'];
    FamilyMemberName = json['FamilyMemberName'];
    Symptom = json['Symptom'];
    MedicineName = json['MedicineName'];
    DoctorName = json['DoctorName'];
    HospitalName = json['HospitalName'];
    DateOfAppointment = json['DateOfAppointment'];
    ReasonForAppointment = json['ReasonForAppointMent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SymptomId'] = this.SymptomId;
    data['mobileNumber'] = this.mobileNumber;
    data['FamilyMemberName'] = this.FamilyMemberName;
    data['Symptom'] = this.Symptom;
    data['MedicineName'] = this.MedicineName;
    data['DoctorName'] = this.DoctorName;
    data['HospitalName'] = this.HospitalName;
    data['DateOfAppointment'] = this.DateOfAppointment;
    data['ReasonForAppointment'] = this.ReasonForAppointment;
    return data;
  }
}
