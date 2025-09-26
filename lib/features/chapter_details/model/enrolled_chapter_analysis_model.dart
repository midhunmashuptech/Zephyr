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
  double? totalAccessPercentage;

  Analysis(
      {this.video,
      this.material,
      this.practiceTest,
      this.totalAccessPercentage});

  Analysis.fromJson(Map<String, dynamic> json) {
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
    material =
        json['material'] != null ? new Video.fromJson(json['material']) : null;
    practiceTest = json['practice_test'] != null
        ? new Video.fromJson(json['practice_test'])
        : null;
    totalAccessPercentage = json['totalAccessPercentage'];
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
