import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/constants/app_constants.dart';
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

  void _showHtmlDialog(BuildContext context, String syllabusData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(20),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7, maxHeight: MediaQuery.of(context).size.height * 0.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                const Text(
                  'Test Syllabus',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // HTML Content with scrolling
                Expanded(
                  child: SingleChildScrollView(
                    child: Html(
                      data: syllabusData
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Close Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/lottie/nodata.json", height: 200),
                      Text("No Upcoming Test Series Found"),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ))
                : Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => _showHtmlDialog(context,testSeriesProvider.upcomingTestsList[index].syllabus ?? '''<h3>No Syllabus Data Found!</h3>''' ),
                          child: TestSeriesCard(
                              type: "main_test",
                              testid: testSeriesProvider.upcomingTestsList[index].id
                                  .toString(),
                              isUpcoming: true,
                              title: testSeriesProvider.upcomingTestsList[index].title ??
                                  "Title",
                              startDate: formatDateTime(
                                  testSeriesProvider.upcomingTestsList[index].start ??
                                      "Date"),
                              endDate: formatDateTime(
                                  testSeriesProvider.upcomingTestsList[index].end ??
                                      "Date"),
                              duration: (testSeriesProvider
                                          .upcomingTestsList[index].duration ??
                                      "Duration")
                                  .toString(),
                              questions:
                                  (testSeriesProvider.upcomingTestsList[index].totalQuestions ?? 0)
                                      .toString(),
                              maxMarks: (testSeriesProvider.upcomingTestsList[index].maxMarks ?? 0).toString()),
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
