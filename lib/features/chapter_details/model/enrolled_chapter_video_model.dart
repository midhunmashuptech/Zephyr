class EnrolledChapterVideosModel {
  String? type;
  List<Videos>? videos;

  EnrolledChapterVideosModel({this.type, this.videos});

  EnrolledChapterVideosModel.fromJson(Map<String, dynamic> json) {
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
  int? courseChapterVideosId;
  int? courseChapterId;
  int? videoListId;
  String? videoid;
  String? title;
  String? hls;
  String? embededlink;
  int? duration;
  String? description;
  String? source;
  String? thumbnail;

  Videos(
      {this.courseChapterVideosId,
      this.courseChapterId,
      this.videoListId,
      this.videoid,
      this.title,
      this.hls,
      this.embededlink,
      this.duration,
      this.description,
      this.source,
      this.thumbnail});

  Videos.fromJson(Map<String, dynamic> json) {
    courseChapterVideosId = json['course_chapter_videos_id'];
    courseChapterId = json['course_chapter_id'];
    videoListId = json['video_list_id'];
    videoid = json['videoid'];
    title = json['title'];
    hls = json['hls'];
    embededlink = json['embededlink'];
    duration = json['duration'];
    description = json['description'];
    source = json['source'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_chapter_videos_id'] = this.courseChapterVideosId;
    data['course_chapter_id'] = this.courseChapterId;
    data['video_list_id'] = this.videoListId;
    data['videoid'] = this.videoid;
    data['title'] = this.title;
    data['hls'] = this.hls;
    data['embededlink'] = this.embededlink;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['source'] = this.source;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
