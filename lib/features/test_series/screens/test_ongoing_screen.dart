import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/test_series/provider/test_series_provider.dart';
import 'package:zephyr/features/test_series/widgets/test_series_card.dart';

class OngoingTestModel {
  final String title;
  final String startDate;
  final String endDate;
  final String duration;
  final String questions;

  OngoingTestModel({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.questions,
  });
}

class TestOngoingScreen extends StatefulWidget {
  const TestOngoingScreen({super.key});

  @override
  State<TestOngoingScreen> createState() => _TestOngoingScreenState();
}

class _TestOngoingScreenState extends State<TestOngoingScreen> {
  TestSeriesProvider testSeriesProvider = TestSeriesProvider();

  @override
  void initState() {
    super.initState();
      loadOngoingTests();
  }

  Future<void> loadOngoingTests() async {
    final loadprovider = context.read<TestSeriesProvider>();
    await loadprovider.fetchOngoingTestSeries(context: context);
  }

  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString).toLocal();
    final formatter = DateFormat("dd MMMM, yyyy | hh:mm a");
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final testSeriesProvider = context.watch<TestSeriesProvider>();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: testSeriesProvider.isOngoingTestLoading
            ? Center(child: CircularProgressIndicator())
            : testSeriesProvider.ongoingTestsList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lottie/nodata.json", height: 200),
                        Text("No Ongoing Test Series Available Now"),
                        SizedBox(height: 40,)
                      ],
                    ))
                : Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => TestSeriesCard(
                                  type: "main_test",
                                  testid: testSeriesProvider
                                      .ongoingTestsList[index].id
                                      .toString(),
                                  isOngoing: true,
                                  title: testSeriesProvider
                                          .ongoingTestsList[index].title ??
                                      "Title",
                                  startDate: formatDateTime(testSeriesProvider
                                          .ongoingTestsList[index].start ??
                                      ""),
                                  endDate: formatDateTime(
                                      testSeriesProvider.ongoingTestsList[index].end ?? ""),
                                  duration: (testSeriesProvider.ongoingTestsList[index].duration ?? "").toString(),
                                  questions: (testSeriesProvider.ongoingTestsList[index].totalQuestions ?? 0).toString(),
                                  maxMarks: (testSeriesProvider.ongoingTestsList[index].maxMarks ?? 0).toString()),
                              separatorBuilder: (context, _) => SizedBox(height: 5),
                              itemCount: testSeriesProvider.ongoingTestsList.length)),
                    ],
                  ),
      )),
    );
  }
}
