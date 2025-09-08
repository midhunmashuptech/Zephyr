import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/model/user.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/features/drawer/services/drawer_service.dart';

class EditProfileProvider extends ChangeNotifier {
  bool _isDataLoading = false;
  bool get isDataLoading => _isDataLoading;

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  String? _checkedOption;
  String? get checkedOption => _checkedOption;

  void radiocheck(String? checkedValue) {
    _checkedOption = checkedValue;
    notifyListeners();
  }

  void loadingTrue() {
    _isDataLoading = true;
    notifyListeners();
  }

  void loadingFalse() {
    _isDataLoading = false;
    notifyListeners();
  }

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

  Future<void> updateDetails({
    required BuildContext context,
    required String name,
    required String email,
    required String gender,
    required String dob,
    required String school,
    required String classStudying,
    required String syllabusId,
    required String address,
    required String district,
    required String state,
    required String country,
    required String secondaryPhone,
  }) async {
    _isUpdating = true;
    notifyListeners();
    final response = await DrawerService().updateUserDetails(
        context: context,
        name: name,
        email: email,
        gender: gender,
        dob: dob,
        school: school,
        classStudying: classStudying,
        syllabusId: syllabusId,
        address: address,
        district: district,
        state: state,
        country: country,
        secondaryPhone: secondaryPhone);
    if (response == null) {
      _isUpdating = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        final userdetails = response.user;
        final userDetailProvider = context.read<UserDetailsProvider>();
        userDetailProvider.setUserDetails(userdetails ?? User());
        showSnackBar("success", "Successfully updated the details");
        _isUpdating = false;
        notifyListeners();
      } else {
        showSnackBar("error", "something went wrong");
      }
    }
  }
}
