import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/screens/bottom_nav_screen.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/auth/login/model/login_model.dart';
import 'package:zephyr/features/auth/login/model/verify_phone_model.dart';
import 'package:zephyr/features/auth/login/screens/login.dart';

class LoginService {
  final ApiService _apiService = ApiService();

  Future<void> login(
    BuildContext context, {
    required String countryCode,
    required String phone,
    required String password,
  }) async {
    print(countryCode + " " + phone + " " + password);

    final request = http.MultipartRequest('POST', Uri.parse(loginUrl));
    request.fields.addAll({
      "country_code": countryCode.substring(1),
      "phone": phone,
      "password": password,
    });

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = json.decode(responseBody);

      final loginModel = LoginModel.fromJson(responseJson);
      if (loginModel.type == "success") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => BottomNavScreen()));
      } else {
        showSnackBar("Invalid Credentials",
            loginModel.message ?? "Your password is incorrect!");
      }
    } else if (response.statusCode == 401) {
      showSnackBar("Invalid Credentials", "Your password is incorrect!");
    }
  }

  Future<VerifyPhoneNumberModel> verifyPhoneNumber(
    BuildContext context, {
    required String countryCode,
    required String phone,
  }) async {
    final responseJson = await _apiService.authPostRequest(
      url: verifyPhoneUrl,
      fields: {
        "country_code": countryCode,
        "phone": phone,
      },
    );

    final verifyPhoneNumberModel =
        VerifyPhoneNumberModel.fromJson(responseJson);
    return verifyPhoneNumberModel;
  }
}
