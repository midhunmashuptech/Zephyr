class UploadProfileImageModel {
  String? type;
  String? message;
  String? url;

  UploadProfileImageModel({this.type, this.message, this.url});

  UploadProfileImageModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['url'] = this.url;
    return data;
  }
}
