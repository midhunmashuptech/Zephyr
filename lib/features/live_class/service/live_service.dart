import 'package:flutter/material.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/live_class/model/ongoing_live_model.dart';

class LiveService {

  //On Going Live
  Future<OnGoingLiveModel?> getOnGoingLive(
      {required BuildContext context}) async {
    final responseJson = await ApiService().getRequest(url: ongoingLiveUrl);
    if (responseJson == null) {
      showSnackBar("Error", "Error fetching ongoing live classes");
    } else {
      final ongoingLiveModel = OnGoingLiveModel.fromJson(responseJson);
      if (ongoingLiveModel.type == "success") {
        showSnackBar("Success", "Successfully fetched");
        return ongoingLiveModel;
      }
    }
      return null;
  }
}
