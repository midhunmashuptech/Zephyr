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
  String? url;
  String? password;
  int? duration;
  Faculty? faculty;
  String? start;
  String? end;
  String? description;
  int? isFeatured;

  LiveClasses(
      {this.id,
      this.title,
      this.url,
      this.password,
      this.duration,
      this.faculty,
      this.start,
      this.end,
      this.description,
      this.isFeatured});

  LiveClasses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    password = json['password'];
    duration = json['duration'];
    faculty =
        json['faculty'] != null ? new Faculty.fromJson(json['faculty']) : null;
    start = json['start'];
    end = json['end'];
    description = json['description'];
    isFeatured = json['is_featured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
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
    return data;
  }
}

class Faculty {
  int? id;
  String? name;
  String? image;
  String? role;

  Faculty({this.id, this.name, this.image, this.role});

  Faculty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['role'] = this.role;
    return data;
  }
}
