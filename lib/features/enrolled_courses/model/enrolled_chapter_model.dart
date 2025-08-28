class EnrolledChapterModel {
  String? type;
  List<Chapters>? chapters;

  EnrolledChapterModel({this.type, this.chapters});

  EnrolledChapterModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapters {
  int? courseSubjectId;
  int? courseChapterId;
  int? chapterId;
  String? chapterTitle;
  String? thumbnail;

  Chapters(
      {this.courseSubjectId,
      this.courseChapterId,
      this.chapterId,
      this.chapterTitle,
      this.thumbnail});

  Chapters.fromJson(Map<String, dynamic> json) {
    courseSubjectId = json['course_subject_id'];
    courseChapterId = json['course_chapter_id'];
    chapterId = json['chapter_id'];
    chapterTitle = json['chapter_title'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_subject_id'] = this.courseSubjectId;
    data['course_chapter_id'] = this.courseChapterId;
    data['chapter_id'] = this.chapterId;
    data['chapter_title'] = this.chapterTitle;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
