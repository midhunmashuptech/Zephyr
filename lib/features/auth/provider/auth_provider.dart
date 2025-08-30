import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/model/user.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/features/auth/service/login_service.dart';
import 'package:intl_phone_field/phone_number.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool _isVerifyingPhone = false;
  bool get isVerifyingPhone => _isVerifyingPhone;

  bool _isLogining = false;
  bool get isLogining => _isLogining;

  String? userExist;

  String countryISOCode = 'IN';
  String countryCode = '';
  String phoneNumber = '';
  String errorText = '';
  bool isValidNumber = false;

  /// Update phone number & validate
  void updatePhoneNumber(PhoneNumber value) {
    countryISOCode = value.countryISOCode;
    countryCode = value.countryCode;
    phoneNumber = value.number;

    if (phoneNumber.isEmpty) {
      errorText = "Mobile number is required";
      isValidNumber = false;
    } else if (!value.isValidNumber()) {
      errorText = "Enter a valid mobile number";
      isValidNumber = false;
    } else {
      errorText = '';
      isValidNumber = true;
    }

    notifyListeners();
  }

  Future<void> userLogin(BuildContext context, String phone, String countryCode,
      String password) async {
    _isLogining = true;
    notifyListeners();

    final response = await LoginService().login(context,
        countryCode: countryCode, phone: phone, password: password);
    if (response == null) {
      showSnackBar("Error", "Something went wrong! please try again");
    } else {
      if (response.type == "success" &&
          response.token != null &&
          response.token != "") {
        // Writing token to Flutter secure Storage
        await _secureStorage.write(key: "token", value: response.token);

        // Reading token from Flutter secure Storage
        final token = await _secureStorage.read(key: "token");

        context
            .read<UserDetailsProvider>()
            .setUserDetails(response.user ?? User());

        print(token);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavScreen()),
        );
      }
    }
  }

  Future<void> verifyPhoneNumber(
      BuildContext context, String phone, String countryCode) async {
    _isVerifyingPhone = true;
    notifyListeners();

    final response = await LoginService()
        .verifyPhoneNumber(context, countryCode: countryCode, phone: phone);
    if (response == null) {
      userExist == "error";
    } else {
      print(response.exists);
      if (response.exists == true) {
        userExist = "true";
      } else if (response.exists == false) {
        userExist = "false";
      }
    }
    notifyListeners();

    _isVerifyingPhone = false;
    notifyListeners();
  }
}
