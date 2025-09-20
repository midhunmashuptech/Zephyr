import 'package:flutter/widgets.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/test_series/model/upcoming_testseries_model.dart'
    as upcoming_test_model;
import 'package:zephyr/features/test_series/model/ongoing_testseries_model.dart'
    as ongoing_test_model;
import 'package:zephyr/features/test_series/service/test_series_service.dart';

class TestSeriesProvider extends ChangeNotifier {
  bool _isOngoingTestLoading = false;
  bool get isOngoingTestLoading => _isOngoingTestLoading;

  bool _isUpcomingTestLoading = false;
  bool get isUpcomingTestLoading => _isUpcomingTestLoading;

  List<upcoming_test_model.TestSeries> _upcomingTestsList = [];
  List<upcoming_test_model.TestSeries> get upcomingTestsList =>
      _upcomingTestsList;

  List<ongoing_test_model.TestSeries> _ongoingTestsList = [];
  List<ongoing_test_model.TestSeries> get ongoingTestsList => _ongoingTestsList;

//Ongoing Test Series
  Future<void> fetchOngoingTestSeries({required BuildContext context}) async {
    _isOngoingTestLoading = true;
    notifyListeners();
    final response =
        await TestSeriesService().getOngoingTestSeries(context: context);
    if (response == null) {
      _isOngoingTestLoading = false;
      notifyListeners();
      showSnackBar("Error", "Error fetching Ongoing Tests");
    } else {
      if (response.type == "success") {
        _ongoingTestsList = response.testSeries ?? [];
        debugPrint(ongoingTestsList.length.toString());
        notifyListeners();
        showSnackBar("Success", "Successfully fetched Ongoing Tests");
        _isOngoingTestLoading = false;
        notifyListeners();
      }
    }
  }

  //Upcoming Test Series
  Future<void> fetchUpcomingTestSeries({required BuildContext context}) async {
    _isUpcomingTestLoading = true;
    notifyListeners();
    final response =
        await TestSeriesService().getUpcomingTestSeries(context: context);
    if (response == null) {
      showSnackBar("Error", "Error Fetching Upcoming Tests");
      _isUpcomingTestLoading = false;
      notifyListeners();
    } else {
      if (response.type == "success") {
        _upcomingTestsList = response.testSeries ?? [];
        notifyListeners();
        showSnackBar("Success", "Successfully Fetched Upcoming Tests");
        _isUpcomingTestLoading = false;
        notifyListeners();
      }
    }
  }
}
