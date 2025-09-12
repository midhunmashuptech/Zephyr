class EnrolledChapterMaterialsModel {
  String? type;
  List<Materials>? materials;

  EnrolledChapterMaterialsModel({this.type, this.materials});

  EnrolledChapterMaterialsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['materials'] != null) {
      materials = <Materials>[];
      json['materials'].forEach((v) {
        materials!.add(new Materials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.materials != null) {
      data['materials'] = this.materials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Materials {
  int? batchMaterialId;
  int? courseChapterMaterialId;
  int? courseChapterId;
  int? materialId;
  String? title;
  String? description;
  String? link;

  Materials(
      {this.batchMaterialId,
      this.courseChapterMaterialId,
      this.courseChapterId,
      this.materialId,
      this.title,
      this.description,
      this.link});

  Materials.fromJson(Map<String, dynamic> json) {
    batchMaterialId = json['batch_material_id'];
    courseChapterMaterialId = json['course_chapter_material_id'];
    courseChapterId = json['course_chapter_id'];
    materialId = json['material_id'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_material_id'] = this.batchMaterialId;
    data['course_chapter_material_id'] = this.courseChapterMaterialId;
    data['course_chapter_id'] = this.courseChapterId;
    data['material_id'] = this.materialId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['link'] = this.link;
    return data;
  }
}
