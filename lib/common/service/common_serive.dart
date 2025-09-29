import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/model/user.dart';
import 'package:zephyr/common/model/user_details_model.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/constants/config.dart';

class CommonSerive {
  //Mobile Number Verification
  Future<UserDetailsModel?> fetchUserDetails(BuildContext context) async {
    final responseJson = await ApiService().getRequest(
      url: getUserDetailsUrl,
    );

    if (responseJson == null || responseJson.isEmpty) {
      showSnackBar("Error", "Json Error");
      return null;
    } else {
      final userDetailModel = UserDetailsModel.fromJson(responseJson);
      if (userDetailModel.type == "success") {
        final userProvider = context.read<UserDetailsProvider>();
        userProvider.setUserDetails(userDetailModel.user ?? User());
        return userDetailModel;
      } else {
        showSnackBar("Error", "User details not fetched");
        return userDetailModel;
      }
    }
  }
}
