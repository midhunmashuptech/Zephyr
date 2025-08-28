import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/model/user.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/features/auth/login/model/verify_phone_model.dart';
import 'package:zephyr/features/auth/service/login_service.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool _isVerifyingPhone = false;
  bool get isVerifyingPhone => _isVerifyingPhone;

  bool _isLogining = false;
  bool get isLogining => _isLogining;

  String? userExist;

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

        context.read<UserDetailsProvider>().setUserDetails(response.user ?? User());

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
