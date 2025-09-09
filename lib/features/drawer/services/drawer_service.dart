import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/drawer/models/password_reset_model.dart';
import 'package:zephyr/features/drawer/models/update_user_detail_model.dart';
import 'package:zephyr/features/drawer/models/upload_profile_picture_model.dart';

class DrawerService {
  final ApiService _apiService = ApiService();

  //Reset Password
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
      // "email": email,
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

  //Upload Profile Picture

  Future<UploadProfileImageModel?> uploadProfileImage({
    required String filePath,
    required BuildContext context,
  }) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(updateProfilePictureUrl));

      request.files
          .add(await http.MultipartFile.fromPath('profile_picture', filePath));

      FlutterSecureStorage secureStorage = FlutterSecureStorage();
      final token = await secureStorage.read(key: "token");
      final headers = {
        'Authorization': 'Bearer $token',
      };
      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseData);
        var uploadProfileImageModel =
            UploadProfileImageModel.fromJson(jsonResponse);
        if (uploadProfileImageModel.type == 'success') {
          showSnackBar("Success", 'Image uploaded successfully');
        } else {
          showSnackBar("Failed", "Failed to upload image");
        }
        return uploadProfileImageModel;
      } else {
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
