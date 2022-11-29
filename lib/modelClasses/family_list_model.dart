class familyListModel {
  String? Name;
  String? Count;

  familyListModel({this.Name, this.Count});

  familyListModel.fromJson(Map<String, dynamic> json) {
    Name = json['name'];
    Count = json['Count'];
  }

  familyListModel.fromMap(Map<String, Object?> first);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.Name;
    data['Count'] = this.Count;
    return data;
  }
}