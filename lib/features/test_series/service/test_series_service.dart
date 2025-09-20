import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/test_series/model/ongoing_testseries_model.dart';
import 'package:zephyr/features/test_series/model/upcoming_testseries_model.dart';

class TestSeriesService {
  
  //Ongoing Test Series
  Future<OngoingTestSeriesModel?> getOngoingTestSeries(
      {required BuildContext context}) async {
    final responseJson =
        await ApiService().getRequest(url: ongoingTestSeriesUrl);
    if (responseJson == null) {
      showSnackBar("error", "Something went wrong");
    } else {
      final ongoingTestSeriesModel =
          OngoingTestSeriesModel.fromJson(responseJson);
      return ongoingTestSeriesModel;
    }
    return null;
  }

  //Upcoming Test Series
  Future<UpcomingTestSeriesModel?> getUpcomingTestSeries(
      {required BuildContext context}) async {
    final responseJson =
        await ApiService().getRequest(url: upcomingTestSeriesUrl);
    if (responseJson == null) {
      showSnackBar("Error", "Something went wrong");
    } else {
      final upcomingTestSeriesModel =
          UpcomingTestSeriesModel.fromJson(responseJson);
      showSnackBar("Success", "upcoming test series loaded");
      return upcomingTestSeriesModel;
    }
    return null;
  }
}
