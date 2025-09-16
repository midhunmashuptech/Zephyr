import 'package:flutter/widgets.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/live_class/model/ongoing_live_model.dart'
    as ongoing_live_model;
import 'package:zephyr/features/live_class/model/recording_live_model.dart'as recording_live_model;
import 'package:zephyr/features/live_class/model/upcoming_live_model.dart'
    as upcoming_live_model;
import 'package:zephyr/features/live_class/service/live_service.dart';

class LiveProvider extends ChangeNotifier {
  bool _isOngoingLoading = false;
  bool get isOngoingLoading => _isOngoingLoading;

  bool _isUpcomingLoading = false;
  bool get isUpcomingLoading => _isUpcomingLoading;

  List<upcoming_live_model.LiveClasses> _upcomingLive = [];
  List<upcoming_live_model.LiveClasses> get upcomingLive => _upcomingLive;

  List<ongoing_live_model.LiveClasses> _ongoingLive = [];
  List<ongoing_live_model.LiveClasses> get ongoingLive => _ongoingLive;

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
        _isUpcomingLoading = false;
        notifyListeners();
      }
    }
  }

  //Recordings Live 
  
}
