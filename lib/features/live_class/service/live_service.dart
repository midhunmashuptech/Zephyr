import 'package:flutter/material.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/live_class/model/ongoing_live_model.dart';
import 'package:zephyr/features/live_class/model/recording_live_model.dart';
import 'package:zephyr/features/live_class/model/upcoming_live_model.dart';

class LiveService {
  
  //On Going Live Class
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

  //UpComing Live Class
  Future<UpcomingLiveModel?> getUpcomingLive(
      {required BuildContext context}) async {
    final responseJson = await ApiService().getRequest(url: upcomingLiveUrl);
    if (responseJson == null) {
      showSnackBar("Error", "Something went wrong");
    } else {
      final upcomingLiveModel = UpcomingLiveModel.fromJson(responseJson);
      showSnackBar("success", "fetched successfully");
      return upcomingLiveModel;
    }
    return null;
  }

  //Recordings Live Class
  Future<RecordingLiveModel?> getRecordingsLive(
      {required BuildContext context, required String date}) async {
    final responseJson = await ApiService()
        .postRequest(url: recordingLiveUrl, fields: {"date": date});
    if (responseJson == null) {
      showSnackBar("failed", "Something went wrong");
    } else {
      final recordingLiveModel = RecordingLiveModel.fromJson(responseJson);
      return recordingLiveModel;
    }
    return null;
  }
}
