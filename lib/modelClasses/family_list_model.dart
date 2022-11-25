class familyListModel {
  String? nameOfFamilyMember;
  String? prescriptionCount;

  familyListModel({this.nameOfFamilyMember, this.prescriptionCount});

  familyListModel.fromJson(Map<String, dynamic> json) {
    nameOfFamilyMember = json['Name of Family Member'];
    prescriptionCount = json['Prescription Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name of Family Member'] = this.nameOfFamilyMember;
    data['Prescription Count'] = this.prescriptionCount;
    return data;
  }
}