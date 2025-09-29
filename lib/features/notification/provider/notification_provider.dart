import 'package:flutter/material.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/notification/model/notification_model.dart';
import 'package:zephyr/features/notification/service/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  //notification variables
  bool _isNotificationsLoading = false;
  bool get isNotificationsLoading => _isNotificationsLoading;

  List<Notifications> _notificationsList = [];
  List<Notifications> get notificationsList => _notificationsList;

  Future<void> fetchNotifications({required BuildContext context}) async {
    _isNotificationsLoading = true;
    notifyListeners();
    final response =
        await NotificationService().getNotifications(context: context);
    if (response == null) {
      showSnackBar("Error",
          "Couldn't load Notifications at this moment.Please try again later");
      _notificationsList = [];
      _isNotificationsLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _notificationsList = response.notifications ?? [];
        notifyListeners();
        _isNotificationsLoading = false;
        notifyListeners();
      } else {
        _notificationsList = [];
        _isNotificationsLoading = false;
        notifyListeners();
      }
    }
  }
}
