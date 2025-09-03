class ActiveCourseModel {
  String? type;
  List<Course>? course;

  ActiveCourseModel({this.type, this.course});

  ActiveCourseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['course'] != null) {
      course = <Course>[];
      json['course'].forEach((v) {
        course!.add(new Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.course != null) {
      data['course'] = this.course!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Course {
  int? id;
  String? title;
  String? thumbnail;
  String? start;
  String? end;
  int? duration;
  String? durationType;
  String? type;
  String? level;
  int? publish;
  String? description;
  String? price;
  String? discountType;
  String? discountValue;
  int? createdBy;
  int? updatedBy;
  int? status;
  String? createdAt;
  String? updatedAt;

  Course(
      {this.id,
      this.title,
      this.thumbnail,
      this.start,
      this.end,
      this.duration,
      this.durationType,
      this.type,
      this.level,
      this.publish,
      this.description,
      this.price,
      this.discountType,
      this.discountValue,
      this.createdBy,
      this.updatedBy,
      this.status,
      this.createdAt,
      this.updatedAt});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    start = json['start'];
    end = json['end'];
    duration = json['duration'];
    durationType = json['duration_type'];
    type = json['type'];
    level = json['level'];
    publish = json['publish'];
    description = json['description'];
    price = json['price'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['start'] = this.start;
    data['end'] = this.end;
    data['duration'] = this.duration;
    data['duration_type'] = this.durationType;
    data['type'] = this.type;
    data['level'] = this.level;
    data['publish'] = this.publish;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
