class CourseEnrollmentsModel {
  String? type;
  List<Enrollments>? enrollments;

  CourseEnrollmentsModel({this.type, this.enrollments});

  CourseEnrollmentsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['enrollments'] != null) {
      enrollments = <Enrollments>[];
      json['enrollments'].forEach((v) {
        enrollments!.add(new Enrollments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.enrollments != null) {
      data['enrollments'] = this.enrollments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Enrollments {
  int? enrollmentId;
  int? userId;
  int? courseId;
  int? batchId;
  String? batchName;
  int? status;

  Enrollments(
      {this.enrollmentId,
      this.userId,
      this.courseId,
      this.batchId,
      this.batchName,
      this.status});

  Enrollments.fromJson(Map<String, dynamic> json) {
    enrollmentId = json['enrollment_id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    batchId = json['batch_id'];
    batchName = json['batch_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enrollment_id'] = this.enrollmentId;
    data['user_id'] = this.userId;
    data['course_id'] = this.courseId;
    data['batch_id'] = this.batchId;
    data['batch_name'] = this.batchName;
    data['status'] = this.status;
    return data;
  }
}
