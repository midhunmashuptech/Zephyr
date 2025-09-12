class CategoryBasedCourseModel {
  String? type;
  List<AllCourses>? allCourses;

  CategoryBasedCourseModel({this.type, this.allCourses});

  CategoryBasedCourseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['courses'] != null) {
      allCourses = <AllCourses>[];
      json['courses'].forEach((v) {
        allCourses!.add(new AllCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.allCourses != null) {
      data['courses'] = this.allCourses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCourses {
  int? id;
  String? title;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Courses>? courses;

  AllCourses(
      {this.id,
      this.title,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.courses});

  AllCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
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
  int? featured;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Courses(
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
      this.featured,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Courses.fromJson(Map<String, dynamic> json) {
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
    featured = json['featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    data['featured'] = this.featured;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? categoryId;
  int? courseId;

  Pivot({this.categoryId, this.courseId});

  Pivot.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    courseId = json['course_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['course_id'] = this.courseId;
    return data;
  }
}
