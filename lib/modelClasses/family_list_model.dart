class familyListModel {
  String? Name;
  int? id;
  int? Count;

  familyListModel({this.Name, this.id, this.Count});

  familyListModel.fromJson(Map<String, dynamic> json) {
    Name = json['name'];
    id = json['id'];
    Count = json['Count'];
  }

  familyListModel.fromMap(Map<String, Object?> first);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.Name;
    data['id'] = this.id;
    data['Count'] = this.Count;
    return data;
  }
}
