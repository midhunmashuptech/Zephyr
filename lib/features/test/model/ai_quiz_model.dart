class AiQuizModel {
  String? type;
  Params? params;
  List<Questions>? questions;

  AiQuizModel({this.type, this.params, this.questions});

  AiQuizModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    params =
        json['params'] != null ? new Params.fromJson(json['params']) : null;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.params != null) {
      data['params'] = this.params!.toJson();
    }
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Params {
  String? type;
  String? subject;
  String? chapter;
  String? topic;
  String? difficulty;
  String? count;

  Params(
      {this.type,
      this.subject,
      this.chapter,
      this.topic,
      this.difficulty,
      this.count});

  Params.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    subject = json['subject'];
    chapter = json['chapter'];
    topic = json['topic'];
    difficulty = json['difficulty'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['subject'] = this.subject;
    data['chapter'] = this.chapter;
    data['topic'] = this.topic;
    data['difficulty'] = this.difficulty;
    data['count'] = this.count;
    return data;
  }
}

class Questions {
  String? questionText;
  List<String>? options;
  int? correctOption;
  String? explanation;

  Questions(
      {this.questionText, this.options, this.correctOption, this.explanation});

  Questions.fromJson(Map<String, dynamic> json) {
    questionText = json['question_text'];
    options = json['options'].cast<String>();
    correctOption = json['correct_option'];
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_text'] = this.questionText;
    data['options'] = this.options;
    data['correct_option'] = this.correctOption;
    data['explanation'] = this.explanation;
    return data;
  }
}
