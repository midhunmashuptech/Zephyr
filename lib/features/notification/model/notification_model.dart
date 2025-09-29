class NotificationModel {
  String? type;
  List<Notifications>? notifications;

  NotificationModel({this.type, this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? id;
  String? title;
  String? message;
  String? data;
  String? topic;
  String? image;
  String? status;
  String? sentAt;
  String? createdAt;
  String? updatedAt;

  Notifications(
      {this.id,
      this.title,
      this.message,
      this.data,
      this.topic,
      this.image,
      this.status,
      this.sentAt,
      this.createdAt,
      this.updatedAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    data = json['data'];
    topic = json['topic'];
    image = json['image'];
    status = json['status'];
    sentAt = json['sent_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['data'] = this.data;
    data['topic'] = this.topic;
    data['image'] = this.image;
    data['status'] = this.status;
    data['sent_at'] = this.sentAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
