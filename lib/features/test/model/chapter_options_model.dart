class ChapterOptionsModel {
	String? type;
	List<Chapters>? chapters;

	ChapterOptionsModel({this.type, this.chapters});

	ChapterOptionsModel.fromJson(Map<String, dynamic> json) {
		type = json['type'];
		if (json['chapters'] != null) {
			chapters = <Chapters>[];
			json['chapters'].forEach((v) { chapters!.add(new Chapters.fromJson(v)); });
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
	int? id;
	int? classId;
	int? subject;
	String? title;
	String? image;
	bool? status;
	String? createdAt;
	String? updatedAt;

	Chapters({this.id, this.classId, this.subject, this.title, this.image, this.status, this.createdAt, this.updatedAt});

	Chapters.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		classId = json['class'];
		subject = json['subject'];
		title = json['title'];
		image = json['image'];
		status = json['status'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['class'] = this.classId;
		data['subject'] = this.subject;
		data['title'] = this.title;
		data['image'] = this.image;
		data['status'] = this.status;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		return data;
	}
}
