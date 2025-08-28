class VerifyPhoneNumberModel {
  String? type;
  String? message;
  bool? exists;

  VerifyPhoneNumberModel({this.type, this.message, this.exists});

  VerifyPhoneNumberModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    exists = json['exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['exists'] = this.exists;
    return data;
  }
}
