import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/test_series/provider/test_series_provider.dart';
import 'package:zephyr/features/test_series/widgets/test_series_card.dart';

class UpcomingTestModel {
  final String title;
  final String startDate;
  final String endDate;
  final String duration;
  final String questions;

  UpcomingTestModel({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.questions,
  });
}

class TestUpmoningScreen extends StatefulWidget {
  const TestUpmoningScreen({super.key});

  @override
  State<TestUpmoningScreen> createState() => _TestUpmoningScreenState();
}

class _TestUpmoningScreenState extends State<TestUpmoningScreen> {
  TestSeriesProvider testSeriesProvider = TestSeriesProvider();
  List<UpcomingTestModel> upcomingTests = [
    UpcomingTestModel(
        title: "Weekly Test 1 Class 06 (19-11-2023)",
        startDate: "20 Aug, 2025 |  17:30",
        endDate: "20 Aug, 2025 |  18:30",
        duration: "60",
        questions: "30"),
    UpcomingTestModel(
        title: "Weekly Test 2 Class 06 (19-11-2023)",
        startDate: "20 Aug, 2025 |  17:30",
        endDate: "20 Aug, 2025 |  18:30",
        duration: "60",
        questions: "30"),
  ];
  @override
  void initState() {
    super.initState();
    loadUpcomingTests();
  }

  Future<void> loadUpcomingTests() async {
    final loadProvider = context.read<TestSeriesProvider>();
    await loadProvider.fetchUpcomingTestSeries(context: context);
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
        child: testSeriesProvider.isUpcomingTestLoading
            ? Center(child: CircularProgressIndicator())
            : testSeriesProvider.upcomingTestsList.isEmpty
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Column(
                      children: [
                        Lottie.asset("assets/lottie/nodata.json", height: 200),
                        Text("No Assignments Found"),
                      ],
                    ),
                  ))
                : Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                        itemBuilder: (context, index) => TestSeriesCard(
                          isUpcoming: true,
                          title: testSeriesProvider
                                  .upcomingTestsList[index].title ??
                              "Title",
                          startDate: formatDateTime(testSeriesProvider
                                  .upcomingTestsList[index].start ??
                              "Date"),
                          endDate: formatDateTime(
                              testSeriesProvider.upcomingTestsList[index].end ??
                                  "Date"),
                          duration: (testSeriesProvider
                                      .upcomingTestsList[index].duration ??
                                  "Duration")
                              .toString(),
                          questions: "27",
                        ),
                        itemCount: testSeriesProvider.upcomingTestsList.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 5),
                      )),
                    ],
                  ),
      )),
    );
  }
}
