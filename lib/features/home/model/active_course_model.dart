import 'package:zephyr/common/model/course_ratings_model.dart';

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
  int? publish;
  String? price;
  String? discountType;
  String? discountValue;
  int? status;
  int? featured;
  bool? isEnrolled;
  double? averageRating;
  List<CourseRatings>? courseRatings;

  Course(
      {this.id,
      this.title,
      this.thumbnail,
      this.publish,
      this.price,
      this.discountType,
      this.discountValue,
      this.status,
      this.featured,
      this.isEnrolled,
      this.averageRating,
      this.courseRatings});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    publish = json['publish'];
    price = json['price'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    status = json['status'];
    featured = json['featured'];
    isEnrolled = json['is_enrolled'];
    averageRating = double.parse(json['average_rating'].toString());
    if (json['course_ratings'] != null) {
      courseRatings = <CourseRatings>[];
      json['course_ratings'].forEach((v) {
        courseRatings!.add(new CourseRatings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['publish'] = this.publish;
    data['price'] = this.price;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['is_enrolled'] = this.isEnrolled;
    data['average_rating'] = this.averageRating;
    if (this.courseRatings != null) {
      data['course_ratings'] =
          this.courseRatings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

