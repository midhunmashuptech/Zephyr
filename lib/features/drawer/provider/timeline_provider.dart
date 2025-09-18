import 'package:flutter/material.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/drawer/services/drawer_service.dart';

class TimelineProvider extends ChangeNotifier {
  bool _isTimelineLoading = false;
  bool get isTimelineLoading => _isTimelineLoading;

  // Get all timeline activities
  Future<void> fetchTimelineActivities({required BuildContext context}) async {
    _isTimelineLoading = true;
    notifyListeners();

    final response = await DrawerService().getTimelineActivities(context);

    if (response == null) {
      showSnackBar("Error", "Error Fetching Timeline Activities");
      _isTimelineLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        // Setting Timeline Responses
        notifyListeners();
        _isTimelineLoading = false;
        notifyListeners();
      } else {
        showSnackBar("Error", "Something went wrong! ${response.type}");
        _isTimelineLoading = false;
        notifyListeners();
      }
    }
  }

  // Posting a timeline activity
  Future<void> postTimelineActivity(
      {required BuildContext context,
      required String contentType,
      required String contentId}) async {
    final response = await DrawerService().postTimelineActivities(context,
        contentType: contentType, contentId: contentId);

    if (response == null) {
      showSnackBar("Error", "Error Posting Timeline Activity");
    } else {
      if (response.type == "success") {
        debugPrint("Error Posting Timeline Activity");
      } else {
        showSnackBar("Error", "Something went wrong! ${response.type}");
      }
    }
  }
}
