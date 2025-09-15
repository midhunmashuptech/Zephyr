class CourseRatings {
  int? id;
  int? courseId;
  int? userId;
  int? rating;
  String? review;
  String? createdAt;
  String? updatedAt;

  CourseRatings(
      {this.id,
      this.courseId,
      this.userId,
      this.rating,
      this.review,
      this.createdAt,
      this.updatedAt});

  CourseRatings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    userId = json['user_id'];
    rating = json['rating'];
    review = json['review'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['user_id'] = this.userId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}