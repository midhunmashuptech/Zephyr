import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/auth/login/model/login_model.dart';
import 'package:zephyr/features/auth/login/model/reset_password_login_model.dart';
import 'package:zephyr/features/auth/login/model/verify_phone_model.dart';

class LoginService {
  final ApiService _apiService = ApiService();

  //Login
  Future<LoginModel?> login(
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

    // final responseJson = await _apiService.authPostRequest(
    //   url: loginUrl,
    //   fields: {
    //     "country_code": countryCode.substring(1),
    //     "phone": phone,
    //     "password": password,
    //   },
    // );

    // if (responseJson == null || responseJson.isEmpty) {
    //   showSnackBar("Error", "Json Error");
    //   return null;
    // } else {
    //   final loginModel = LoginModel.fromJson(responseJson);
    //   if (loginModel.type == "success") {
    //     return loginModel;
    //   }
    //   return null;
    // }

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = json.decode(responseBody);

      final loginModel = LoginModel.fromJson(responseJson);
      if (loginModel.type == "success") {
        return loginModel;
      } else {
        showSnackBar("Invalid Credentials",
            loginModel.message ?? "Your password is incorrect!");
      }
    } else if (response.statusCode == 401) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = json.decode(responseBody);

      final loginModel = LoginModel.fromJson(responseJson);
      showSnackBar(loginModel.message ?? "Invalid Credentials",
          "Your password is incorrect!");
    }
    return null;
  }

  //Mobile Number Verification
  Future<VerifyPhoneNumberModel?> verifyPhoneNumber(
    BuildContext context, {
    required String countryCode,
    required String phone,
  }) async {
    final responseJson = await _apiService.authPostRequest(
      url: verifyPhoneUrl,
      fields: {
        "country_code": countryCode.substring(1),
        "phone": phone,
      },
    );

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final verifyPhoneNumberModel =
          VerifyPhoneNumberModel.fromJson(responseJson);
      if (verifyPhoneNumberModel.type == "success") {
        return verifyPhoneNumberModel;
      } else {
        return verifyPhoneNumberModel;
      }
    }
  }

  //Fetch User Details
  Future<VerifyPhoneNumberModel?> getUserDetails(
    BuildContext context, {
    required String countryCode,
    required String phone,
  }) async {
    final responseJson = await _apiService.getRequest(
      url: verifyPhoneUrl,
    );

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final verifyPhoneNumberModel =
          VerifyPhoneNumberModel.fromJson(responseJson);
      if (verifyPhoneNumberModel.type == "success") {
        return verifyPhoneNumberModel;
      } else {
        return verifyPhoneNumberModel;
      }
    }
  }

  // Reset Password Login
  Future<ResetPasswordLoginModel?> resetPassword(
      {required BuildContext context,
      required String phone,
      required String countryCode,
      required String password}) async {
    final responseJson = await ApiService().authPostRequest(
        url: resetPasswordUrl,
        fields: {
          "phone": phone,
          "country_code": countryCode.substring(1),
          "password": password
        });

    final resetPasswordLoginModel =
        ResetPasswordLoginModel.fromJson(responseJson);
    if (resetPasswordLoginModel.type == "success") {
      showSnackBar("success", "reset successful");
    }
    return resetPasswordLoginModel;
  }
}
