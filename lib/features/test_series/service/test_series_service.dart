import 'package:flutter/widgets.dart';
import 'package:zephyr/api_files/api_service.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/constants/config.dart';
import 'package:zephyr/features/test_series/model/attended_testseries_model.dart';
import 'package:zephyr/features/test_series/model/ongoing_testseries_model.dart';
import 'package:zephyr/features/test_series/model/testseries_analysis_model.dart';
import 'package:zephyr/features/test_series/model/testseries_leaderboard_model.dart';
import 'package:zephyr/features/test_series/model/upcoming_testseries_model.dart';

class TestSeriesService {
  //Ongoing Test Series
  Future<OngoingTestSeriesModel?> getOngoingTestSeries(
      {required BuildContext context}) async {
    final responseJson =
        await ApiService().getRequest(url: ongoingTestSeriesUrl);
    if (responseJson == null) {
      return null;
    } else {
      final ongoingTestSeriesModel =
          OngoingTestSeriesModel.fromJson(responseJson);
      return ongoingTestSeriesModel;
    }
  }

  //Upcoming Test Series
  Future<UpcomingTestSeriesModel?> getUpcomingTestSeries(
      {required BuildContext context}) async {
    final responseJson =
        await ApiService().getRequest(url: upcomingTestSeriesUrl);
    if (responseJson == null) {
      return null;
    } else {
      final upcomingTestSeriesModel =
          UpcomingTestSeriesModel.fromJson(responseJson);
      return upcomingTestSeriesModel;
    }
  }

  //Attended Test Series
  Future<AttendedTestSeriesModel?> getAttendedTestSeries(
      {required BuildContext context}) async {
    final responseJson =
        await ApiService().getRequest(url: attendedTestSeriesUrl);
    if (responseJson == null) {
      return null;
    } else {
      final attendedTestSeriesModel =
          AttendedTestSeriesModel.fromJson(responseJson);
      return attendedTestSeriesModel;
    }
  }

  //Attended Test Series
  Future<TestseriesAnalysisModel?> getTestSeriesAnalysis(
      {required BuildContext context, required String testId}) async {
    final responseJson = await ApiService()
        .postRequest(url: testSeriesAnalysisUrl, fields: {"test_id": testId});
    if (responseJson == null) {
      return null;
    } else {
      final testSeriesAnalysisModel =
          TestseriesAnalysisModel.fromJson(responseJson);
      return testSeriesAnalysisModel;
    }
  }

  //Test Series LeaderBoard
  Future<TestSeriesLeaderBoardModel?> getLeaderBoard(
      {required BuildContext context, required String testId}) async {
    final responseJson =
        await ApiService().getRequest(url: "$testSeriesLeaderBoardUrl$testId");
    if (responseJson == null) {
      return null;
    } else {
      final testSeriesLeaderBoardModel =
          TestSeriesLeaderBoardModel.fromJson(responseJson);
      return testSeriesLeaderBoardModel;
    }
  }
}
