class AssignmentModel {
  String? type;
  String? message;
  List<Assignments>? assignments;

  AssignmentModel({this.type, this.message, this.assignments});

  AssignmentModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    
    message = json['message'];
    if (json['assignments'] != null) {
      assignments = <Assignments>[];
      json['assignments'].forEach((v) {
        assignments!.add(new Assignments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.assignments != null) {
      data['assignments'] = this.assignments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assignments {
  int? id;
  String? title;
  String? description;
  String? type;
  String? filePath;
  String? htmlContent;
  String? startTime;
  String? endTime;
  int? status;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  List<Batch>? batch;

  Assignments(
      {this.id,
      this.title,
      this.description,
      this.type,
      this.filePath,
      this.htmlContent,
      this.startTime,
      this.endTime,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.batch});

  Assignments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    filePath = json['file_path'];
    htmlContent = json['html_content'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['batch'] != null) {
      batch = <Batch>[];
      json['batch'].forEach((v) {
        batch!.add(new Batch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['file_path'] = this.filePath;
    data['html_content'] = this.htmlContent;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.batch != null) {
      data['batch'] = this.batch!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Batch {
  int? id;
  int? batchId;
  int? assignmentId;
  String? createdAt;
  String? updatedAt;

  Batch(
      {this.id,
      this.batchId,
      this.assignmentId,
      this.createdAt,
      this.updatedAt});

  Batch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchId = json['batch_id'];
    assignmentId = json['assignment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['batch_id'] = this.batchId;
    data['assignment_id'] = this.assignmentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
