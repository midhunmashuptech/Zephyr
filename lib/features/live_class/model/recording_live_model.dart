class RecordingLiveModel {
  String? type;
  List<LiveClasses>? liveClasses;

  RecordingLiveModel({this.type, this.liveClasses});

  RecordingLiveModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['live_classes'] != null) {
      liveClasses = <LiveClasses>[];
      json['live_classes'].forEach((v) {
        liveClasses!.add(new LiveClasses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.liveClasses != null) {
      data['live_classes'] = this.liveClasses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveClasses {
  int? id;
  String? title;
  String? meetid;
  String? type;
  int? account;
  String? url;
  String? password;
  int? duration;
  Faculty? faculty;
  String? start;
  String? end;
  String? description;
  int? isFeatured;
  String? thumbnail;
  String? recordingSource;
  String? videoid;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? embededLink;
  String? hls;

  LiveClasses(
      {this.id,
      this.title,
      this.meetid,
      this.type,
      this.account,
      this.url,
      this.password,
      this.duration,
      this.faculty,
      this.start,
      this.end,
      this.description,
      this.isFeatured,
      this.thumbnail,
      this.recordingSource,
      this.videoid,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.embededLink,
      this.hls});

  LiveClasses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    meetid = json['meetid'];
    type = json['type'];
    account = json['account'];
    url = json['url'];
    password = json['password'];
    duration = json['duration'];
    faculty =
        json['faculty'] != null ? new Faculty.fromJson(json['faculty']) : null;
    start = json['start'];
    end = json['end'];
    description = json['description'];
    isFeatured = json['is_featured'];
    thumbnail = json['thumbnail'];
    recordingSource = json['recording_source'];
    videoid = json['videoid'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    embededLink = json['embeded_link'];
    hls = json['hls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['meetid'] = this.meetid;
    data['type'] = this.type;
    data['account'] = this.account;
    data['url'] = this.url;
    data['password'] = this.password;
    data['duration'] = this.duration;
    if (this.faculty != null) {
      data['faculty'] = this.faculty!.toJson();
    }
    data['start'] = this.start;
    data['end'] = this.end;
    data['description'] = this.description;
    data['is_featured'] = this.isFeatured;
    data['thumbnail'] = this.thumbnail;
    data['recording_source'] = this.recordingSource;
    data['videoid'] = this.videoid;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['embeded_link'] = this.embededLink;
    data['hls'] = this.hls;
    return data;
  }
}

class Faculty {
  int? id;
  String? name;
  String? image;
  Faculty(
      {this.id,
      this.name,
      this.image,});

  Faculty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
