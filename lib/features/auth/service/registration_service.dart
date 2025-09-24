import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/auth/registration/model/registration_dropdown_options_model.dart';
import 'package:zephyr/features/auth/registration/model/registration_model.dart';
class RegistrationService {
  //Dropdown Options
  Future<RegistrationDropdownOptionsModel?> getRegisterDropdownOptions() async {
    final responseJson = await ApiService().authGetRequest(
      url: registrationDropdownOptionsUrl,
    );

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final dropdownOptionsModel =
          RegistrationDropdownOptionsModel.fromJson(responseJson);
      if (dropdownOptionsModel.type == "success") {
        return dropdownOptionsModel;
      } else {
        return null;
      }
    }
  }

//Registration
  Future<RegistrationModel?> registerUser(
    BuildContext context, {
    required String name,
    required String email,
    required String phone,
    required String countryCode,
    required String dob,
    required String gender,
    required String school,
    required String classStudying,
    required String syllabus,
    required String password,
  }) async {
    final responseJson = await ApiService().authPostRequest(
      url: registerUrl,
      fields: {
        "name": name,
        "email": email,
        "phone": phone,
        "country_code": countryCode,
        "dob": dob,
        "gender": gender,
        "school": school,
        "class_studying": classStudying,
        "syllabus": syllabus,
        "password": password
      },
    );
    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("error", "Json Error");
      return null;
    } else {
      final registrationModel = RegistrationModel.fromJson(responseJson);
      if (registrationModel.type == "success") {
        return registrationModel;
      } else {
        return null;
      }
    }
  }

  
}
