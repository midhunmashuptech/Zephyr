import 'package:flutter/material.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/notification/model/notification_model.dart';

class NotificationService {
  
  //Notifications
  Future<NotificationModel?> getNotifications(
      {required BuildContext context}) async {
    final responseJson = await ApiService().getRequest(url: notificationsUrl);
    if (responseJson == null) {
      showSnackBar("error", "something went wrong");
      return null;
    } else {
      final notificationModel = NotificationModel.fromJson(responseJson);
      return notificationModel;
    }
  }
}
