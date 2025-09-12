class CourseDetailModel {
  String? type;
  String? message;
  Data? data;

  CourseDetailModel({this.type, this.message, this.data});

  CourseDetailModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? thumbnail;
  String? type;
  String? level;
  String? price;
  String? description;
  String? duration;
  String? startDate;
  String? endDate;
  List<String>? categories;
  List<Subjects>? subjects;
  List<Ratings>? ratings;
  List<String>? likes;
  int? likeCount;
  int? ratingCount;
  double? averageRating;

  Data(
      {this.id,
      this.title,
      this.thumbnail,
      this.type,
      this.level,
      this.price,
      this.description,
      this.duration,
      this.startDate,
      this.endDate,
      this.categories,
      this.subjects,
      this.ratings,
      this.likes,
      this.likeCount,
      this.ratingCount,
      this.averageRating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    type = json['type'];
    level = json['level'];
    price = json['price'];
    description = json['description'];
    duration = json['duration'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    categories = json['categories'].cast<String>();
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
    likes = json['likes'].cast<String>();
    likeCount = json['like_count'];
    ratingCount = json['rating_count'];
    averageRating = json['average_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['type'] = this.type;
    data['level'] = this.level;
    data['price'] = this.price;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['categories'] = this.categories;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    data['likes'] = this.likes;
    data['like_count'] = this.likeCount;
    data['rating_count'] = this.ratingCount;
    data['average_rating'] = this.averageRating;
    return data;
  }
}

class Subjects {
  int? classId;
  String? className;
  int? subjectId;
  int? courseSubjectId;
  String? subject;
  List<Chapters>? chapters;

  Subjects(
      {this.classId,
      this.className,
      this.subjectId,
      this.courseSubjectId,
      this.subject,
      this.chapters});

  Subjects.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    className = json['class'];
    subjectId = json['subject_id'];
    courseSubjectId = json['course_subject_id'];
    subject = json['subject'];
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId;
    data['class'] = this.className;
    data['subject_id'] = this.subjectId;
    data['course_subject_id'] = this.courseSubjectId;
    data['subject'] = this.subject;
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapters {
  int? courseChapterId;
  String? chapterTitle;
  String? chapterThumbnail;

  Chapters({this.courseChapterId, this.chapterTitle, this.chapterThumbnail});

  Chapters.fromJson(Map<String, dynamic> json) {
    courseChapterId = json['course_chapter_id'];
    chapterTitle = json['chapter_title'];
    chapterThumbnail = json['chapter_thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_chapter_id'] = this.courseChapterId;
    data['chapter_title'] = this.chapterTitle;
    data['chapter_thumbnail'] = this.chapterThumbnail;
    return data;
  }
}

class Ratings {
  String? user;
  String? image;
  int? rating;
  String? review;

  Ratings({this.user, this.image, this.rating, this.review});

  Ratings.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    image = json['image'];
    rating = json['rating'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}
