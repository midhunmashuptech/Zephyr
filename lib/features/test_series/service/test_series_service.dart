import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/test_series/model/attended_testseries_model.dart';
import 'package:zephyr/features/test_series/model/ongoing_testseries_model.dart';
import 'package:zephyr/features/test_series/model/testseries_leaderboard_model.dart';
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

  //Attended Test Series
  Future<AttendedTestSeriesModel?> getAttendedTestSeries(
      {required BuildContext context}) async {
    final responseJson =
        await ApiService().getRequest(url: attendedTestSeriesUrl);
    if (responseJson == null) {
      showSnackBar("Error", "Something went wrong");
    } else {
      final attendedTestSeriesModel =
          AttendedTestSeriesModel.fromJson(responseJson);
      showSnackBar("Success", "Successfully loaded Attended Test Series");
      return attendedTestSeriesModel;
    }
    return null;
  }

  //Test Series LeaderBoard
  Future<TestSeriesLeaderBoardModel?> getLeaderBoard(
      {required BuildContext context, required String testId}) async {
    final responseJson =
        await ApiService().getRequest(url: "$testSeriesLeaderBoardUrl$testId");
    if (responseJson == null) {
      showSnackBar("Error", "Something went wrong");
    } else {
      final testSeriesLeaderBoardModel =
          TestSeriesLeaderBoardModel.fromJson(responseJson);
      showSnackBar("Success", "Successfully loaded leaderboard");
      return testSeriesLeaderBoardModel;
    }
    return null;
  }
}
