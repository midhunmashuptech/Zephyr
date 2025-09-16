import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/live_class/model/ongoing_live_model.dart'
    as ongoing_live_model;
import 'package:zephyr/features/live_class/model/recording_live_model.dart'
    as recording_live_model;
import 'package:zephyr/features/live_class/model/upcoming_live_model.dart'
    as upcoming_live_model;
import 'package:zephyr/features/live_class/service/live_service.dart';

class LiveProvider extends ChangeNotifier {
  DateTime _recordingSelectedDate = DateTime.now();
  DateTime get recordingSelectedDate => _recordingSelectedDate;

  void setRecordingDate(DateTime date) {
    _recordingSelectedDate = date;
    notifyListeners();
  }

  bool _isOngoingLoading = false;
  bool get isOngoingLoading => _isOngoingLoading;

  bool _isUpcomingLoading = false;
  bool get isUpcomingLoading => _isUpcomingLoading;

  bool _isRecordingLoading = false;
  bool get isRecordingLoading => _isRecordingLoading;

  List<upcoming_live_model.LiveClasses> _upcomingLive = [];
  List<upcoming_live_model.LiveClasses> get upcomingLive => _upcomingLive;

  List<ongoing_live_model.LiveClasses> _ongoingLive = [];
  List<ongoing_live_model.LiveClasses> get ongoingLive => _ongoingLive;

  List<recording_live_model.LiveClasses> _recordingLive = [];
  List<recording_live_model.LiveClasses> get recordingLive => _recordingLive;

  //OnGoing Live
  Future<void> fetchOngoingLive({required BuildContext context}) async {
    _isOngoingLoading = true;
    notifyListeners();
    final response = await LiveService().getOnGoingLive(context: context);
    if (response == null) {
      showSnackBar("Error", "Error Fetching Ongoing Live Classes");
      _isOngoingLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _ongoingLive = response.liveClasses ?? [];
        notifyListeners();
        _isOngoingLoading = false;
        notifyListeners();
      } else {
        showSnackBar("Error", "Something went wrong");
        _isOngoingLoading = false;
        notifyListeners();
      }
    }
  }

  //Upcoming Live
  Future<void> fetchUpcomingLive({required BuildContext context}) async {
    _isUpcomingLoading = true;
    notifyListeners();
    final response = await LiveService().getUpcomingLive(context: context);
    if (response == null) {
      showSnackBar("Error", "Error Fetching the ongoing live classes");
      _isUpcomingLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _upcomingLive = response.liveClasses ?? [];
        notifyListeners();
        showSnackBar("Success", "Succesfully fetched UpComing Live Classes");
        _isUpcomingLoading = false;
        notifyListeners();
      }
    }
  }

  //Recordings Live
  Future<void> fetchRecordingLive(
      {required BuildContext context}) async {
    _isRecordingLoading = true;
    _recordingLive = [];
    notifyListeners();
    final response =
        await LiveService().getRecordingsLive(context: context, date: DateFormat("dd-MM-yyyy").format(_recordingSelectedDate));
    if (response == null) {
      showSnackBar("Error", "Something went wrong");
      _isRecordingLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _recordingLive = response.liveClasses ?? [];
        notifyListeners();
        showSnackBar("Success", "Successfully fetched recorded Live Classes");
        _isRecordingLoading = false;
        notifyListeners();
      }
    }
  }
}
