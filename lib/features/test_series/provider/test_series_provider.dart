import 'package:flutter/widgets.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/features/test_series/model/ongoing_testseries_model.dart';
import 'package:zephyr/features/test_series/service/test_series_service.dart';

class TestSeriesProvider extends ChangeNotifier {
  bool _isOngoingTestLoading = false;
  bool get isOngoingTestLoading => _isOngoingTestLoading;

  List<TestSeries> _ongoingTestsList = [];
  List<TestSeries> get ongoingTestsList => _ongoingTestsList;
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
}
