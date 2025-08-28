class EnrolledChapterVideoModel {
  String? type;
  List<Null>? videos;

  EnrolledChapterVideoModel({this.type, this.videos});

  EnrolledChapterVideoModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['videos'] != null) {
      videos = <Null>[];
      json['videos'].forEach((v) {
        videos!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
