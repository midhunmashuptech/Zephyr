import 'package:flutter/material.dart';
import 'package:zephyr/common/model/user.dart';

class UserDetailsProvider extends ChangeNotifier {
  User _userDetails = User();
  User get userDetails => _userDetails;

  /// Set full user details
  void setUserDetails(User userDetails) {
    _userDetails = userDetails;
    notifyListeners();
  }

  /// Update single fields
  void updateName(String name) {
    _userDetails.name = name;
    notifyListeners();
  }

  void updateEmail(String email) {
    _userDetails.email = email;
    notifyListeners();
  }

  void updatePhone(String phone) {
    _userDetails.phone = phone;
    notifyListeners();
  }

  void updateSecondaryPhone(String secondaryPhone) {
    _userDetails.secondaryPhone = secondaryPhone;
    notifyListeners();
  }

  void updateProfileImage(String imageUrl) {
    _userDetails.image = imageUrl;
    notifyListeners();
  }

  void updateAddress({
    String? address,
    String? district,
    String? state,
    String? country,
    String? pinCode,
  }) {
    if (address != null) _userDetails.address = address;
    if (district != null) _userDetails.district = district;
    if (state != null) _userDetails.state = state;
    if (country != null) _userDetails.country = country;
    if (pinCode != null) _userDetails.pinCode = pinCode;
    notifyListeners();
  }

  /// Clear all user details (logout)
  void clearUser() {
    _userDetails = User();
    notifyListeners();
  }
}
