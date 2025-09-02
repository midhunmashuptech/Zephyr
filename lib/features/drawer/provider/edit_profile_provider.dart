import 'package:flutter/foundation.dart';

class EditProfileProvider extends ChangeNotifier {
  String _username = "";
  String get username => _username;

  String _emailAddress = "";
  String get emailAddress => _emailAddress;

  void setUpdatedProfile(String name, String email) {
    _username = name;
    _emailAddress = email;
    notifyListeners();
    print(_username);
    print(_emailAddress);
  }
}
