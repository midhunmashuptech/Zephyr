import 'package:zephyr/common/model/user.dart';

class UpdateUserDetailModel {
  String? type;
  String? message;
  User? user;

  UpdateUserDetailModel({this.type, this.message, this.user});

  UpdateUserDetailModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}