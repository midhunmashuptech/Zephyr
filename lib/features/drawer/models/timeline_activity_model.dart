class TimelineActivityModel {
  String? type;
  List<Activities>? activities;

  TimelineActivityModel({this.type, this.activities});

  TimelineActivityModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  Timeline? timeline;
  ContentDetails? contentDetails;

  Activities({this.timeline, this.contentDetails});

  Activities.fromJson(Map<String, dynamic> json) {
    timeline = json['timeline'] != null
        ? new Timeline.fromJson(json['timeline'])
        : null;
    contentDetails = json['content_details'] != null
        ? new ContentDetails.fromJson(json['content_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeline != null) {
      data['timeline'] = this.timeline!.toJson();
    }
    if (this.contentDetails != null) {
      data['content_details'] = this.contentDetails!.toJson();
    }
    return data;
  }
}

class Timeline {
  int? id;
  int? userId;
  String? contentType;
  int? contentId;
  String? accessedAt;
  String? device;
  String? batchId;
  String? createdAt;
  String? updatedAt;

  Timeline(
      {this.id,
      this.userId,
      this.contentType,
      this.contentId,
      this.accessedAt,
      this.device,
      this.batchId,
      this.createdAt,
      this.updatedAt});

  Timeline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    contentType = json['content_type'];
    contentId = json['content_id'];
    accessedAt = json['accessed_at'];
    device = json['device'];
    batchId = json['batch_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['content_type'] = this.contentType;
    data['content_id'] = this.contentId;
    data['accessed_at'] = this.accessedAt;
    data['device'] = this.device;
    data['batch_id'] = this.batchId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ContentDetails {
  int? id;
  String? title;
  String? videoid;
  String? embededlink;
  String? hls;
  int? duration;
  String? thumbnail;
  String? description;
  String? createdAt;
  String? updatedAt;

  ContentDetails(
      {this.id,
      this.title,
      this.videoid,
      this.embededlink,
      this.hls,
      this.duration,
      this.thumbnail,
      this.description,
      this.createdAt,
      this.updatedAt});

  ContentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoid = json['videoid'];
    embededlink = json['embededlink'];
    hls = json['hls'];
    duration = json['duration'];
    thumbnail = json['thumbnail'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['videoid'] = this.videoid;
    data['embededlink'] = this.embededlink;
    data['hls'] = this.hls;
    data['duration'] = this.duration;
    data['thumbnail'] = this.thumbnail;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
