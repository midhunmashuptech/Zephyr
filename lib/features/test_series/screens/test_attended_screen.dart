import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  List<AttendedTestModel> attendedTests = [
    AttendedTestModel(
        title: "Weekly Test 1 Class 06 (19-11-2023)",
        submittedDate: "20 Aug, 2025 |  17:30",
        duration: "30 Min"),
    AttendedTestModel(
        title: "Weekly Test 2 Class 06 (19-11-2023)",
        submittedDate: "20 Aug, 2025 |  17:30",
        duration: "30 Min"),
    AttendedTestModel(
        title: "Weekly Test 3 Class 06 (19-11-2023)",
        submittedDate: "20 Aug, 2025 |  17:30",
        duration: "30 Min"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) => TestSeriesCard(
                          testid: "0",
                          type: "main_test",
                          isAttended: true,
                          title: attendedTests[index].title,
                          submissionDate: attendedTests[index].submittedDate,
                          duration: attendedTests[index].duration,
                          questions: "30",
                          maxMarks: "100",
                        ),
                    itemCount: attendedTests.length)),
          ],
        ),
      )),
    );
  }
}
