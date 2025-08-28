class EnrolledChapterVideoModel {
  String? type;
  List<Videos>? videos;

  EnrolledChapterVideoModel({this.type, this.videos});

  EnrolledChapterVideoModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
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

class Videos {
  String? title;
  String? thumbnail;

  Videos({this.title, this.thumbnail});

  Videos.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
