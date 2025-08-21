import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                          isUpcoming: true,
                          title: upcomingTests[index].title,
                          startDate: upcomingTests[index].startDate,
                          endDate: upcomingTests[index].endDate,
                          duration: upcomingTests[index].duration,
                          questions: upcomingTests[index].questions,
                        ),
                    itemCount: upcomingTests.length)),
          ],
        ),
      )),
    );
  }
}
