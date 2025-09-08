import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/drawer/models/password_reset_model.dart';
import 'package:zephyr/features/drawer/models/update_user_detail_model.dart';

class DrawerService {
  final ApiService _apiService = ApiService();

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
    } else if (resetPasswordModel.type == "danger") {
      showSnackBar("Use a different Password",
          resetPasswordModel.message ?? "Something went wrong!");
    } else {
      showSnackBar(
          "Error", resetPasswordModel.message ?? "Something went wrong!");
    }
    return resetPasswordModel;
  }

  //Update User Details
  Future<UpdateUserDetailModel?> updateUserDetails({
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
    final jsonResponse =
        await ApiService().postRequest(url: updateUserDetailsUrl, fields: {
      "name": name,
      "email": email,
      "gender": gender,
      "dob": dob,
      "school": school,
      "class_studying": classStudying,
      // "syllabus_id": syllabusId,
      "address": address,
      "district": district,
      "state": state,
      "country": country,
      "secondary_phone": secondaryPhone
    });
    final updateUserDetailModel = UpdateUserDetailModel.fromJson(jsonResponse);
    if (updateUserDetailModel.type == "success") {
      return updateUserDetailModel;
    } else {
      showSnackBar(
          "Error", updateUserDetailModel.message ?? "Something went wrong!");
      return null;
    }
  }
}
