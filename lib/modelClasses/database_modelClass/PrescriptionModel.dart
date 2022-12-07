class PrescriptionModel {
  int? SymptomId;
  int? FamilyMemberId;
  String? Symptom;
  String? DoctorName;
  String? HospitalName;
  String? DateOfAppointment;
  String? ReasonForAppointment;

  PrescriptionModel({
    this.SymptomId,
    this.FamilyMemberId,
    this.Symptom,
    this.DoctorName,
    this.HospitalName,
    this.DateOfAppointment,
    this.ReasonForAppointment, 
  });

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    SymptomId = json['SymptomId'];
    Symptom = json['Symptom'];
    FamilyMemberId = json['FamilyMemberId'];
    DoctorName = json['DoctorName'];
    HospitalName = json['HospitalName'];
    DateOfAppointment = json['DateOfAppointment'];
    ReasonForAppointment = json['ReasonForAppointment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SymptomId'] = this.SymptomId;
    data['FamilyMemberId'] = this.FamilyMemberId;
    data['Symptom'] = this.Symptom;
    data['DoctorName'] = this.DoctorName;
    data['HospitalName'] = this.HospitalName;
    data['DateOfAppointment'] = this.DateOfAppointment;
    data['ReasonForAppointment'] = this.ReasonForAppointment;
    return data;
  }
}
