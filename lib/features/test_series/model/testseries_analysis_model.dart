class TestseriesAnalysisModel {
  String? type;
  String? message;
  Performance? performance;

  TestseriesAnalysisModel({this.type, this.message, this.performance});

  TestseriesAnalysisModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    performance = json['performance'] != null
        ? new Performance.fromJson(json['performance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.performance != null) {
      data['performance'] = this.performance!.toJson();
    }
    return data;
  }
}

class Performance {
  int? userId;
  String? userName;
  Overall? overall;
  String? answers;
  String? submitTime;
  List<SectionAnalysis>? sectionAnalysis;
  List<SubjectAnalysis>? subjectAnalysis;
  int? rank;

  Performance(
      {this.userId,
      this.userName,
      this.overall,
      this.answers,
      this.submitTime,
      this.sectionAnalysis,
      this.subjectAnalysis,
      this.rank});

  Performance.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    overall =
        json['overall'] != null ? new Overall.fromJson(json['overall']) : null;
    answers = json['answers'];
    submitTime = json['submit_time'];
    if (json['section_analysis'] != null) {
      sectionAnalysis = <SectionAnalysis>[];
      json['section_analysis'].forEach((v) {
        sectionAnalysis!.add(new SectionAnalysis.fromJson(v));
      });
    }
    if (json['subject_analysis'] != null) {
      subjectAnalysis = <SubjectAnalysis>[];
      json['subject_analysis'].forEach((v) {
        subjectAnalysis!.add(new SubjectAnalysis.fromJson(v));
      });
    }
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    if (this.overall != null) {
      data['overall'] = this.overall!.toJson();
    }
    data['answers'] = this.answers;
    data['submit_time'] = this.submitTime;
    if (this.sectionAnalysis != null) {
      data['section_analysis'] =
          this.sectionAnalysis!.map((v) => v.toJson()).toList();
    }
    if (this.subjectAnalysis != null) {
      data['subject_analysis'] =
          this.subjectAnalysis!.map((v) => v.toJson()).toList();
    }
    data['rank'] = this.rank;
    return data;
  }
}

class Overall {
  int? score;
  int? maxMarks;
  int? accuracy;
  double? averageTimePerQuestion;
  Null? pass;
  Count? count;
  Time? time;
  int? correctScore;
  int? incorrectScore;

  Overall(
      {this.score,
      this.maxMarks,
      this.accuracy,
      this.averageTimePerQuestion,
      this.pass,
      this.count,
      this.time,
      this.correctScore,
      this.incorrectScore});

  Overall.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    maxMarks = json['max_marks'];
    accuracy = json['accuracy'];
    averageTimePerQuestion = double.parse(json['average_time_per_question'].toString());
    pass = json['pass'];
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
    correctScore = json['correct_score'];
    incorrectScore = json['incorrect_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['max_marks'] = this.maxMarks;
    data['accuracy'] = this.accuracy;
    data['average_time_per_question'] = this.averageTimePerQuestion;
    data['pass'] = this.pass;
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    if (this.time != null) {
      data['time'] = this.time!.toJson();
    }
    data['correct_score'] = this.correctScore;
    data['incorrect_score'] = this.incorrectScore;
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

class SectionAnalysis {
  String? section;
  int? score;
  Count? count;
  Time? time;
  int? correctScore;
  int? incorrectScore;

  SectionAnalysis(
      {this.section,
      this.score,
      this.count,
      this.time,
      this.correctScore,
      this.incorrectScore});

  SectionAnalysis.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    score = json['score'];
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
    correctScore = json['correct_score'];
    incorrectScore = json['incorrect_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section'] = this.section;
    data['score'] = this.score;
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    if (this.time != null) {
      data['time'] = this.time!.toJson();
    }
    data['correct_score'] = this.correctScore;
    data['incorrect_score'] = this.incorrectScore;
    return data;
  }
}

class SubjectAnalysis {
  String? subject;
  int? score;
  Count? count;
  Time? time;
  int? correctScore;
  int? incorrectScore;

  SubjectAnalysis(
      {this.subject,
      this.score,
      this.count,
      this.time,
      this.correctScore,
      this.incorrectScore});

  SubjectAnalysis.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    score = json['score'];
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
    correctScore = json['correct_score'];
    incorrectScore = json['incorrect_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['score'] = this.score;
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    if (this.time != null) {
      data['time'] = this.time!.toJson();
    }
    data['correct_score'] = this.correctScore;
    data['incorrect_score'] = this.incorrectScore;
    return data;
  }
}
