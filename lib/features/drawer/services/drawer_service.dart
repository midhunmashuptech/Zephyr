import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/drawer/models/password_reset_model.dart';

class DrawerService {
  final ApiService _apiService = ApiService(
      authToken:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NTUzMjg4ODUsImV4cCI6MTc1NTUwMTY4NSwiZGF0YSI6eyJpZCI6IjIxNDQiLCJwaG9uZSI6Ijk2NTY2MjI5OTkiLCJjb3VudHJ5X2NvZGUiOiI5MSJ9fQ.OLJRxyypAqgKilgbBelMbvpkFgYc1Xv7mTRCuBxNvns");

  Future<PasswordResetModel> resetPassword(
      BuildContext context, String newPassword) async {
    print(newPassword);
    final responseJson = await _apiService.postRequest(
        url: resetPasswordUrl, fields: {"new_password": newPassword});

    final resetPasswordModel = PasswordResetModel.fromJson(responseJson);
    if (resetPasswordModel.type == "success") {
      Navigator.pop(context);
      showSnackBar("Success",
          resetPasswordModel.message ?? "Succesfully changed password");
    } else if(resetPasswordModel.type == "danger") {
      showSnackBar(
          "Use a different Password", resetPasswordModel.message ?? "Something went wrong!");
    } else {
      showSnackBar(
          "Error", resetPasswordModel.message ?? "Something went wrong!");
    }
    return resetPasswordModel;
  }
}
