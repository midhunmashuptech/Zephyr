class SubmitAssignmentModel {
  String? type;
  String? message;

  SubmitAssignmentModel({this.type, this.message});

  SubmitAssignmentModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    return data;
  }
}
