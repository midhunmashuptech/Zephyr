class RegistrationDropdownOptionsModel {
  String? type;
  List<ClassStudying>? classStudying;
  List<Syllabus>? syllabuses;

  RegistrationDropdownOptionsModel({this.type, this.classStudying, this.syllabuses});

  RegistrationDropdownOptionsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['class_studying'] != null) {
      classStudying = <ClassStudying>[];
      json['class_studying'].forEach((v) {
        classStudying!.add(new ClassStudying.fromJson(v));
      });
    }
    if (json['syllabuses'] != null) {
      syllabuses = <Syllabus>[];
      json['syllabuses'].forEach((v) {
        syllabuses!.add(new Syllabus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.classStudying != null) {
      data['class_studying'] =
          this.classStudying!.map((v) => v.toJson()).toList();
    }
    if (this.syllabuses != null) {
      data['syllabuses'] = this.syllabuses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassStudying {
  int? id;
  String? title;
  int? status;
  String? createdAt;
  String? updatedAt;

  ClassStudying(
      {this.id, this.title, this.status, this.createdAt, this.updatedAt});

  ClassStudying.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Syllabus {
  int? id;
  String? title;
  int? status;
  String? createdAt;
  String? updatedAt;

  Syllabus(
      {this.id, this.title, this.status, this.createdAt, this.updatedAt});

  Syllabus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
