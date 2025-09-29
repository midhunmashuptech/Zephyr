class EnrolledChapterAnalysisModel {
  String? type;
  Analysis? analysis;

  EnrolledChapterAnalysisModel({this.type, this.analysis});

  EnrolledChapterAnalysisModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    analysis = json['analysis'] != null
        ? new Analysis.fromJson(json['analysis'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.analysis != null) {
      data['analysis'] = this.analysis!.toJson();
    }
    return data;
  }
}

class Analysis {
  Video? video;
  Video? material;
  Video? practiceTest;
  PracticeTotals? practiceTotals;
  double? totalAccessPercentage;

  Analysis(
      {this.video,
      this.material,
      this.practiceTest,
      this.practiceTotals,
      this.totalAccessPercentage});

  Analysis.fromJson(Map<String, dynamic> json) {
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
    material =
        json['material'] != null ? new Video.fromJson(json['material']) : null;
    practiceTest = json['practice_test'] != null
        ? new Video.fromJson(json['practice_test'])
        : null;
    practiceTotals = json['practice_totals'] != null
        ? new PracticeTotals.fromJson(json['practice_totals'])
        : null;
    totalAccessPercentage = double.parse(json['totalAccessPercentage'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    if (this.material != null) {
      data['material'] = this.material!.toJson();
    }
    if (this.practiceTest != null) {
      data['practice_test'] = this.practiceTest!.toJson();
    }
    if (this.practiceTotals != null) {
      data['practice_totals'] = this.practiceTotals!.toJson();
    }
    data['totalAccessPercentage'] = this.totalAccessPercentage;
    return data;
  }
}

class Video {
  int? accessed;
  int? total;
  int? percentage;

  Video({this.accessed, this.total, this.percentage});

  Video.fromJson(Map<String, dynamic> json) {
    accessed = json['accessed'];
    total = json['total'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessed'] = this.accessed;
    data['total'] = this.total;
    data['percentage'] = this.percentage;
    return data;
  }
}

class PracticeTotals {
  Count? count;
  Time? time;

  PracticeTotals({this.count, this.time});

  PracticeTotals.fromJson(Map<String, dynamic> json) {
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    if (this.time != null) {
      data['time'] = this.time!.toJson();
    }
    return data;
  }
}

class Count {
  int? totalCorrect;
  int? totalIncorrect;
  int? totalUnattended;
  int? totalUnanswered;

  Count(
      {this.totalCorrect,
      this.totalIncorrect,
      this.totalUnattended,
      this.totalUnanswered});

  Count.fromJson(Map<String, dynamic> json) {
    totalCorrect = json['total_correct'];
    totalIncorrect = json['total_incorrect'];
    totalUnattended = json['total_unattended'];
    totalUnanswered = json['total_unanswered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_correct'] = this.totalCorrect;
    data['total_incorrect'] = this.totalIncorrect;
    data['total_unattended'] = this.totalUnattended;
    data['total_unanswered'] = this.totalUnanswered;
    return data;
  }
}

class Time {
  int? totalTime;
  int? unansweredTime;
  int? unattendedTime;
  int? correctTime;
  int? incorrectTime;

  Time(
      {this.totalTime,
      this.unansweredTime,
      this.unattendedTime,
      this.correctTime,
      this.incorrectTime});

  Time.fromJson(Map<String, dynamic> json) {
    totalTime = json['total_time'];
    unansweredTime = json['unanswered_time'];
    unattendedTime = json['unattended_time'];
    correctTime = json['correct_time'];
    incorrectTime = json['incorrect_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_time'] = this.totalTime;
    data['unanswered_time'] = this.unansweredTime;
    data['unattended_time'] = this.unattendedTime;
    data['correct_time'] = this.correctTime;
    data['incorrect_time'] = this.incorrectTime;
    return data;
  }
}
