class SymptomsModelClass {
  String? MasterSymptom;
  int? MasterSymptomId;
  SymptomsModelClass({this.MasterSymptom,this.MasterSymptomId});

  SymptomsModelClass.fromJson(Map<String, dynamic> json) {
    MasterSymptom = json['MasterSymptom'];
    MasterSymptomId = json['MasterSymptomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MasterSymptom'] = this.MasterSymptom;
    data['MasterSymptomId'] = this.MasterSymptomId;
    return data;
  }
}
