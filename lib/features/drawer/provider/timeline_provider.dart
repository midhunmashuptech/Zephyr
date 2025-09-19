import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/drawer/models/timeline_activity_model.dart';
import 'package:zephyr/features/drawer/services/drawer_service.dart';

class TimelineProvider extends ChangeNotifier {
  bool _isTimelineLoading = false;
  bool get isTimelineLoading => _isTimelineLoading;

  DateTime _currentSelectedDate = DateTime.now();
  DateTime get currentSelectedDate => _currentSelectedDate;

  void setSelectedDate(DateTime date) {
    _currentSelectedDate = date;
    notifyListeners();
  }

  List<Activities> _timelineActivities = [];
  List<Activities> get timelineActivities => _timelineActivities;

  // Get all timeline activities
  Future<void> fetchTimelineActivities({required BuildContext context}) async {
    _isTimelineLoading = true;
    _timelineActivities = [];
    notifyListeners();

    final response = await DrawerService().getTimelineActivities(context,
        date: DateFormat("yyyy-MM-dd").format(currentSelectedDate));

    if (response == null) {
      showSnackBar("Error", "Error Fetching Timeline Activities");
      _timelineActivities = [];
      _isTimelineLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        // Setting Timeline Responses
        _timelineActivities = response.activities ?? [];
        debugPrint(timelineActivities.length.toString());
        notifyListeners();
        _isTimelineLoading = false;
        notifyListeners();
      } else {
        _timelineActivities = [];
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
        debugPrint("Suxxefully Posting Timeline Activity");
      } else {
        showSnackBar("Error", "Something went wrong! ${response.type}");
      }
    }
  }
}
