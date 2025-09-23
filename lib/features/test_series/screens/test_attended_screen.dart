import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/test_series/model/attended_testseries_model.dart';
import 'package:zephyr/features/test_series/provider/test_series_provider.dart';
import 'package:zephyr/features/test_series/widgets/test_series_card.dart';

class AttendedTestModel {
  final String title;
  final String submittedDate;
  final String duration;

  AttendedTestModel({
    required this.title,
    required this.submittedDate,
    required this.duration,
  });
}

class TestAttendedScreen extends StatefulWidget {
  const TestAttendedScreen({super.key});

  @override
  State<TestAttendedScreen> createState() => _TestAttendedScreenState();
}

class _TestAttendedScreenState extends State<TestAttendedScreen> {
  TestSeriesProvider testSeriesProvider = TestSeriesProvider();
  @override
  void initState() {
    super.initState();
    loadAttendedTestSeries();
  }

  Future<void> loadAttendedTestSeries() async {
    final loadProvider = context.read<TestSeriesProvider>();
    await loadProvider.fetchAttendedTestSeriesModel(context: context);
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
        child: 
        testSeriesProvider.isAttendedTestLoading
        ?Center(child: CircularProgressIndicator())
        :testSeriesProvider.attendedTestList.isEmpty
        ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/lottie/nodata.json",
                                height: 200),
                            Text("No Recordings found!"),
                            SizedBox(height: 10),
                          ],
                        ),
                      )
        :Column(
          children: [
            Expanded(
                child: ListView.separated(
              itemCount: testSeriesProvider.attendedTestList.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) => TestSeriesCard(
                testid:
                    (testSeriesProvider.attendedTestList[index].testId ?? "")
                        .toString(),
                title: (testSeriesProvider.attendedTestList[index].test ??
                            Test(title: "Title"))
                        .title ??
                    "",
                submissionDate: formatDateTime(
                    testSeriesProvider.attendedTestList[index].submitTime ??
                        ""),
                duration: ((testSeriesProvider.attendedTestList[index].test ??
                                Test(duration: 20))
                            .duration ??
                        "")
                    .toString(),
                questions: "30",
                maxMarks: "100",
                type: "main_test",
                isAttended: true,
              ),
            )),
          ],
        ),
      )),
    );
  }
}
