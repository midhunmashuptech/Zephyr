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
        subscriptions!.add(Subscriptions.fromJson(v));
      });
    }
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
  int? videoCount;
  int? pdfCount;
  int? practiceTestCount;
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
      this.videoCount,
      this.pdfCount,
      this.practiceTestCount,
      this.contentCount,
      this.progress});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    courseTitle = json['course_title'];
    courseThumbnail = json['course_thumbnail'];
    courseId = json['course_id'];
    batchId = json['batch_id'];
    batchTitle = json['batch_title'];
    enrollmentId = json['enrollment_id'];
    ratings = json['ratings'];
    videoCount = json['video_count'];
    pdfCount = json['pdf_count'];
    practiceTestCount = json['practice_test_count'];
    contentCount = json['content_count'];
    progress = json['progress'];
  }
}
