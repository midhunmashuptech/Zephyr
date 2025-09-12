class UpcomingLiveModel {
  String? type;
  List<LiveClasses>? liveClasses;

  UpcomingLiveModel({this.type, this.liveClasses});

  UpcomingLiveModel.fromJson(Map<String, dynamic> json) {
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
  String? faculty;
  String? start;
  String? end;
  String? description;
  String? recordingSource;
  String? videoid;
  bool? status;
  String? createdAt;
  String? updatedAt;

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
      this.recordingSource,
      this.videoid,
      this.status,
      this.createdAt,
      this.updatedAt});

  LiveClasses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    meetid = json['meetid'];
    type = json['type'];
    account = json['account'];
    url = json['url'];
    password = json['password'];
    duration = json['duration'];
    faculty = json['faculty'];
    start = json['start'];
    end = json['end'];
    description = json['description'];
    recordingSource = json['recording_source'];
    videoid = json['videoid'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['faculty'] = this.faculty;
    data['start'] = this.start;
    data['end'] = this.end;
    data['description'] = this.description;
    data['recording_source'] = this.recordingSource;
    data['videoid'] = this.videoid;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
