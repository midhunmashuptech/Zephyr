class EnrolledSubjectModel {
  String? type;
  String? subjects;

  EnrolledSubjectModel({this.type, this.subjects});

  EnrolledSubjectModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    subjects = json['subjects'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['subjects'] = this.subjects;
    return data;
  }
}
