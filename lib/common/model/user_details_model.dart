import 'package:zephyr/common/model/user.dart';

class UserDetailsModel {
  String? type;
  User? user;
  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    user = json['user'];
  }
}
