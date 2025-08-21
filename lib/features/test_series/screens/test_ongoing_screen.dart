import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  List<OngoingTestModel> ongoingTests = [
    OngoingTestModel(
        title: "Weekly Test 1 Class 06 (19-11-2023)",
        startDate: "20 Aug, 2025 |  17:30",
        endDate: "20 Aug, 2025 |  18:30",
        duration: "60",
        questions: "30"),
    OngoingTestModel(
        title: "Weekly Test 2 Class 06 (19-11-2023)",
        startDate: "20 Aug, 2025 |  13:30",
        endDate: "20 Aug, 2025 |  14:00",
        duration: "30",
        questions: "10"),
    OngoingTestModel(
        title: "Weekly Test 3 Class 06 (19-11-2023)",
        startDate: "20 Aug, 2025 |  12:30",
        endDate: "20 Aug, 2025 |  13:30",
        duration: "60",
        questions: "20"),
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
                child: ListView.separated(
                    itemBuilder: (context, index) => TestSeriesCard(
                          isOngoing: true,
                          title: ongoingTests[index].title,
                          startDate: ongoingTests[index].startDate,
                          endDate: ongoingTests[index].endDate,
                          duration: ongoingTests[index].duration,
                          questions: ongoingTests[index].questions,
                        ),
                    separatorBuilder: (context, _) => SizedBox(height: 5),
                    itemCount: ongoingTests.length)),
          ],
        ),
      )),
    );
  }
}
