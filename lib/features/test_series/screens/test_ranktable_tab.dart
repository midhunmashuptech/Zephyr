import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zephyr/features/test_series/provider/test_series_provider.dart';

class TestRanktableTab extends StatefulWidget {
  final String maxMark;
  const TestRanktableTab({super.key, required this.maxMark});

  @override
  State<TestRanktableTab> createState() => _TestRanktableTabState();
}

class _TestRanktableTabState extends State<TestRanktableTab> {
  TestSeriesProvider testSeriesProvider = TestSeriesProvider();

  @override
  Widget build(BuildContext context) {
    testSeriesProvider = context.watch<TestSeriesProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Test Ranklist",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder.all(), // Adds border to each cell
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                children: [
                  // Header
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    children: [
                      Padding(
                          padding: EdgeInsets.all(8.0), child: Text("Sl No")),
                      Padding(
                          padding: EdgeInsets.all(8.0), child: Text("Name")),
                      Padding(
                          padding: EdgeInsets.all(8.0), child: Text("Rank")),
                      Padding(
                          padding: EdgeInsets.all(8.0), child: Text("Score")),
                    ],
                  ),
                  ...List.generate(
                    testSeriesProvider.leaderBoardList.length,
                    (index) => TableRow(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255)),
                      children: [
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("${index+1}")),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(testSeriesProvider.leaderBoardList[index].name ?? "Student Name")),
                        Padding(padding: EdgeInsets.all(8.0), child: Text((testSeriesProvider.leaderBoardList[index].rank ?? 0).toString())),
                        Padding(
                            padding: EdgeInsets.all(8.0), child: Text("${testSeriesProvider.leaderBoardList[index].score}")),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
