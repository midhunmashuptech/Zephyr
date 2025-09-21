class EnrolledChapterTestModel {
  String? type;
  List<Tests>? tests;

  EnrolledChapterTestModel({this.type, this.tests});

  EnrolledChapterTestModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['tests'] != null) {
      tests = <Tests>[];
      json['tests'].forEach((v) {
        tests!.add(new Tests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.tests != null) {
      data['tests'] = this.tests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tests {
  int? batchPracticeTestId;
  int? courseChapterPracticeTestId;
  int? courseChapterId;
  int? testId;
  String? title;
  String? description;
  bool? isAttended;
  int? totalQuestions;
  int? duration;
  int? maxMarks;

  Tests(
      {this.batchPracticeTestId,
      this.courseChapterPracticeTestId,
      this.courseChapterId,
      this.testId,
      this.title,
      this.description,
      this.isAttended,
      this.totalQuestions,
      this.duration,
      this.maxMarks});

  Tests.fromJson(Map<String, dynamic> json) {
    batchPracticeTestId = json['batch_practice_test_id'];
    courseChapterPracticeTestId = json['course_chapter_practice_test_id'];
    courseChapterId = json['course_chapter_id'];
    testId = json['test_id'];
    title = json['title'];
    description = json['description'];
    isAttended = json['is_attended'];
    totalQuestions = json['total_questions'];
    duration = json['duration'];
    maxMarks = json['max_marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_practice_test_id'] = this.batchPracticeTestId;
    data['course_chapter_practice_test_id'] = this.courseChapterPracticeTestId;
    data['course_chapter_id'] = this.courseChapterId;
    data['test_id'] = this.testId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['is_attended'] = this.isAttended;
    data['total_questions'] = this.totalQuestions;
    data['total_marks'] = this.duration;
    data['max_marks'] = this.maxMarks;
    return data;
  }
}
