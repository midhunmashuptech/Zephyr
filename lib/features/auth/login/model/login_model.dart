import 'package:zephyr/common/model/user.dart';

class LoginModel {
  String? type;
  String? message;
  String? token;
  User? user;

  LoginModel({this.type, this.message, this.token, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}