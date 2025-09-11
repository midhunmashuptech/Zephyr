import 'package:flutter/widgets.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/live_class/model/ongoing_live_model.dart';
import 'package:zephyr/features/live_class/service/live_service.dart';

class LiveProvider extends ChangeNotifier {
  bool _isOngoingLoading = false;
  bool get isOngoingLoading => _isOngoingLoading;

  List<LiveClasses> _ongoingLive = [];
  List<LiveClasses> get ongoingLive => _ongoingLive;

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
}
