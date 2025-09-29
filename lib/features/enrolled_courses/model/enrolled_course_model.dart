class EnrolledCourseModel {
  String? type;
  String? message;
  List<Subscriptions>? subscriptions;

  EnrolledCourseModel({this.type, this.message, this.subscriptions});

  EnrolledCourseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['subscriptions'].forEach((v) {
        subscriptions!.add(new Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.subscriptions != null) {
      data['subscriptions'] =
          this.subscriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subscriptions {
  String? courseTitle;
  String? courseThumbnail;
  int? courseId;
  int? batchId;
  String? batchTitle;
  int? enrollmentId;
  double? ratings;
  int? contentCount;
  int? progress;

  Subscriptions(
      {this.courseTitle,
      this.courseThumbnail,
      this.courseId,
      this.batchId,
      this.batchTitle,
      this.enrollmentId,
      this.ratings,
      this.contentCount,
      this.progress});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    courseTitle = json['course_title'];
    courseThumbnail = json['course_thumbnail'];
    courseId = json['course_id'];
    batchId = json['batch_id'];
    batchTitle = json['batch_title'];
    enrollmentId = json['enrollment_id'];
    ratings = double.parse(json['ratings'].toString());
    contentCount = json['content_count'];
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_title'] = this.courseTitle;
    data['course_thumbnail'] = this.courseThumbnail;
    data['course_id'] = this.courseId;
    data['batch_id'] = this.batchId;
    data['batch_title'] = this.batchTitle;
    data['enrollment_id'] = this.enrollmentId;
    data['ratings'] = this.ratings;
    data['content_count'] = this.contentCount;
    data['progress'] = this.progress;
    return data;
  }
}
