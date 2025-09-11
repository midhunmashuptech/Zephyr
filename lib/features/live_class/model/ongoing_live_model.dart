class OnGoingLiveModel {
  String? type;
  List<LiveClasses>? liveClasses;

  OnGoingLiveModel({this.type, this.liveClasses});

  OnGoingLiveModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  String? url;
  int? duration;
  Faculty? faculty;
  String? start;
  String? end;
  String? description;

  LiveClasses(
      {this.id,
      this.title,
      this.type,
      this.url,
      this.duration,
      this.faculty,
      this.start,
      this.end,
      this.description});

  LiveClasses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    duration = json['duration'];
    faculty =
        json['faculty'] != null ? new Faculty.fromJson(json['faculty']) : null;
    start = json['start'];
    end = json['end'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['duration'] = this.duration;
    if (this.faculty != null) {
      data['faculty'] = this.faculty!.toJson();
    }
    data['start'] = this.start;
    data['end'] = this.end;
    data['description'] = this.description;
    return data;
  }
}

class Faculty {
  String? name;
  String? image;

  Faculty({this.name, this.image});

  Faculty.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
