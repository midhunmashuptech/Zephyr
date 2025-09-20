import 'package:zephyr/common/model/course_ratings_model.dart';

class FeaturedCourseModel {
  String? type;
  List<Courses>? courses;

  FeaturedCourseModel({this.type, this.courses});

  FeaturedCourseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
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
  int? publish;
  String? price;
  String? discountType;
  String? discountValue;
  int? status;
  int? featured;
  double? averageRating;
  bool? isEnrolled;
  List<CourseRatings>? courseRatings;
  String? type;

  Courses(
      {this.id,
      this.title,
      this.thumbnail,
      this.publish,
      this.price,
      this.discountType,
      this.discountValue,
      this.status,
      this.featured,
      this.averageRating,
      this.isEnrolled,
      this.courseRatings,
      this.type});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    publish = json['publish'];
    price = json['price'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    status = json['status'];
    featured = json['featured'];
    averageRating = double.parse(json['average_rating'].toString());
    isEnrolled = json['is_enrolled'];
    if (json['course_ratings'] != null) {
      courseRatings = <CourseRatings>[];
      json['course_ratings'].forEach((v) {
        courseRatings!.add(new CourseRatings.fromJson(v));
      });
    }
    type = json['type'];
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
    data['average_rating'] = this.averageRating;
    data['is_enrolled'] = this.isEnrolled;
    if (this.courseRatings != null) {
      data['course_ratings'] =
          this.courseRatings!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}
