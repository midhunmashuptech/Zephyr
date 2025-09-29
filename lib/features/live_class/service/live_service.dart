import 'package:flutter/material.dart';
import 'package:zephyr/api_files/api_service.dart';
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
      return null;
    } else {
      final ongoingLiveModel = OnGoingLiveModel.fromJson(responseJson);
      if (ongoingLiveModel.type == "success") {
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
      return null;
    } else {
      final upcomingLiveModel = UpcomingLiveModel.fromJson(responseJson);
      return upcomingLiveModel;
    }
  }

  //Recordings Live Class
  Future<RecordingLiveModel?> getRecordingsLive(
      {required BuildContext context, required String date}) async {
    final responseJson = await ApiService()
        .postRequest(url: recordingLiveUrl, fields: {"date": date});
    if (responseJson == null) {
      return null;
    } else {
      final recordingLiveModel = RecordingLiveModel.fromJson(responseJson);
      return recordingLiveModel;
    }
  }
}
