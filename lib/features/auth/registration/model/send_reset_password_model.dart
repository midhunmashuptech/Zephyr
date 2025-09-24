class SendResetPasswordModel {
  String? type;
  String? message;
  int? otp;

  SendResetPasswordModel({this.type, this.message, this.otp});

  SendResetPasswordModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['otp'] = this.otp;
    return data;
  }
}
