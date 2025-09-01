import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/auth/registration/model/registration_dropdown_options_model.dart';

class RegistrationService {
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
}