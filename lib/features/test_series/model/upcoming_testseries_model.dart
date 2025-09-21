class UpcomingTestSeriesModel {
  String? type;
  List<TestSeries>? testSeries;

  UpcomingTestSeriesModel({this.type, this.testSeries});

  UpcomingTestSeriesModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['test_series'] != null) {
      testSeries = <TestSeries>[];
      json['test_series'].forEach((v) {
        testSeries!.add(new TestSeries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.testSeries != null) {
      data['test_series'] = this.testSeries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestSeries {
  int? id;
  String? title;
  String? start;
  String? end;
  List<SectionData>? sectionData;
  int? duration;
  String? durationType;
  String? syllabus;
  String? instructions;
  String? description;
  String? passMark;
  bool? ranklist;
  bool? answersheet;
  bool? solution;
  bool? performance;
  String? videoSource;
  String? videoId;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? totalQuestions;
  int? maxMarks;

  TestSeries(
      {this.id,
      this.title,
      this.start,
      this.end,
      this.sectionData,
      this.duration,
      this.durationType,
      this.syllabus,
      this.instructions,
      this.description,
      this.passMark,
      this.ranklist,
      this.answersheet,
      this.solution,
      this.performance,
      this.videoSource,
      this.videoId,
      this.status,
      this.createdAt,
      this.totalQuestions,
      this.maxMarks,
      this.updatedAt});

  TestSeries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    start = json['start'];
    end = json['end'];
    if (json['section_data'] != null) {
      sectionData = <SectionData>[];
      json['section_data'].forEach((v) {
        sectionData!.add(new SectionData.fromJson(v));
      });
    }
    duration = json['duration'];
    durationType = json['duration_type'];
    syllabus = json['syllabus'];
    instructions = json['instructions'];
    description = json['description'];
    passMark = json['pass_mark'];
    ranklist = json['ranklist'];
    answersheet = json['answersheet'];
    solution = json['solution'];
    performance = json['performance'];
    videoSource = json['video_source'];
    videoId = json['video_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalQuestions = json['total_questions'];
    maxMarks = json['max_marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start'] = this.start;
    data['end'] = this.end;
    if (this.sectionData != null) {
      data['section_data'] = this.sectionData!.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    data['duration_type'] = this.durationType;
    data['syllabus'] = this.syllabus;
    data['instructions'] = this.instructions;
    data['description'] = this.description;
    data['pass_mark'] = this.passMark;
    data['ranklist'] = this.ranklist;
    data['answersheet'] = this.answersheet;
    data['solution'] = this.solution;
    data['performance'] = this.performance;
    data['video_source'] = this.videoSource;
    data['video_id'] = this.videoId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['total_questions'] = this.totalQuestions;
    data['max_marks'] = this.maxMarks;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SectionData {
  String? title;
  String? instructions;
  String? min;
  String? max;
  List<Data>? data;

  SectionData({this.title, this.instructions, this.min, this.max, this.data});

  SectionData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    instructions = json['instructions'];
    min = json['min'];
    max = json['max'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['instructions'] = this.instructions;
    data['min'] = this.min;
    data['max'] = this.max;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? qid;
  int? correct;
  int? incorrect;

  Data({this.qid, this.correct, this.incorrect});

  Data.fromJson(Map<String, dynamic> json) {
    qid = json['qid'];
    correct = json['correct'];
    incorrect = json['incorrect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qid'] = this.qid;
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    return data;
  }
}
