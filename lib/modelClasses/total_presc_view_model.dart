class totalPrescViewModel {
  String? MedicineName;
  String? ExpiryDate;
  String? Symptom;
  String? name;
  String? DoctorName;
  String? HospitalName;
  String? DateOfAppointment;
  String? ReasonForAppointment;
  String? NextAppointmentDate;
  int? TabletsCount;
  String? PrescFiles;
  String? MedicinePhoto;
  totalPrescViewModel({
    this.DateOfAppointment,
    this.DoctorName,
    this.ExpiryDate,
    this.HospitalName,
    this.MedicineName,
    this.NextAppointmentDate,
    this.ReasonForAppointment,
    this.TabletsCount,
    this.name,
    this.Symptom,
    this.PrescFiles,
    this.MedicinePhoto,
  });

  totalPrescViewModel.fromJson(Map<String, dynamic> json) {
    MedicineName = json['MedicineName'];
    ExpiryDate = json['ExpiryDate'];
    Symptom = json['Symptom'];
    DateOfAppointment = json['DateOfAppointment'];
    DoctorName = json['DoctorName'];
    HospitalName = json['HospitalName'];
    NextAppointmentDate = json['NextAppointmentDate'];
    ReasonForAppointment = json['ReasonForAppointment'];
    TabletsCount = json['TabletsCount'];
    name = json['name'];
    PrescFiles = json['PrescFiles'];
    MedicinePhoto = json['MedicinePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MedicineName'] = this.MedicineName;
    data['ExpiryDate'] = this.ExpiryDate;
    data['Symptom'] = this.Symptom;
    data['DateOfAppointment'] = this.DateOfAppointment;
    data['DoctorName'] = this.DoctorName;
    data['HospitalName'] = this.HospitalName;
    data['NextAppointmentDate'] = this.NextAppointmentDate;
    data['ReasonForAppointment'] = this.ReasonForAppointment;
    data['TabletsCount'] = this.TabletsCount;
    data['name'] = this.name;
    data['PrescFiles'] = this.PrescFiles;
    data['MedicinePhoto'] = this.MedicinePhoto;
    return data;
  }
}
/* name,Symptom varchar(255),
      DoctorName varchar(255),
      HospitalName varchar(255),
      DateOfAppointment varchar(255),
      ReasonForAppointment varchar(255),
      NextAppointmentDate varchar(255),
      PrescFiles varchar(255)
      MedicineName varchar(255),
ExpiryDate varchar(255),
MedicinePhoto varchar(255),
TabletsCount INTEGER,
*/