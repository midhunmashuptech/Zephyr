class PostTimelineActivityModel {
  String? type;
  Data? data;

  PostTimelineActivityModel({this.type, this.data});

  PostTimelineActivityModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? contentType;
  String? contentId;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.contentType,
      this.contentId,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    contentType = json['content_type'];
    contentId = json['content_id'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_type'] = this.contentType;
    data['content_id'] = this.contentId;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
