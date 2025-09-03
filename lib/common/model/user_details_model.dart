import 'package:zephyr/common/model/user.dart';

class UserDetailsModel {
  String? type;
  User? user;

  UserDetailsModel({this.type, this.user});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
