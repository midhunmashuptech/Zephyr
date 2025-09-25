import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/icons/ion.dart';
import 'package:iconify_flutter_plus/icons/ph.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/common/widgets/custom_button.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test_series/model/testseries_analysis_model.dart';
import 'package:zephyr/features/test_series/provider/test_series_provider.dart';
import 'package:zephyr/features/test_series/screens/test_series_rank_list.dart';
import 'package:zephyr/features/test_series/screens/test_series_solutions_screen.dart';
import 'package:zephyr/features/test_series/widgets/test_detail_widget.dart';
import 'package:zephyr/features/test_series/widgets/test_report_card.dart';

class TestReviewScreen extends StatefulWidget {
  final String type;
  final String testid;
  final String title;
  const TestReviewScreen(
      {super.key,
      required this.type,
      required this.testid,
      required this.title});

  @override
  State<TestReviewScreen> createState() => _TestReviewScreenState();
}

class _TestReviewScreenState extends State<TestReviewScreen> {
  UserDetailsProvider userDetailsProvider = UserDetailsProvider();
  TestSeriesProvider testSeriesProvider = TestSeriesProvider();

  @override
  void initState() {
    super.initState();
    loadAnalysisData();
  }

  Future<void> loadAnalysisData() async {
    final loadProvider = context.read<TestSeriesProvider>();
    await loadProvider.fetchTestSeriesAnalysis(
        context: context, testId: widget.testid);
  }

  @override
  Widget build(BuildContext context) {
    userDetailsProvider = context.watch<UserDetailsProvider>();
    testSeriesProvider = context.watch<TestSeriesProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Test Analysis"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestSeriesSolutionsScreen(
                            type: widget.type,
                            testid: widget.testid,
                            userid: userDetailsProvider.userDetails.id
                                .toString()))),
                child: Text(
                  "View Solution",
                  style: TextStyle(color: AppColors.primaryBlue),
                )),
          )
        ],
      ),
      body: SafeArea(
        child: testSeriesProvider.isAnalysisLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Report Card
                          TestReportCard(
                            title: widget.title,
                            date: formatDate(
                                '${(testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).submitTime}',
                                "dd/MM/yyyy"),
                            duration:
                                (((testSeriesProvider.testseriesAnalysisModel
                                                                .performance ??
                                                            Performance())
                                                        .overall ??
                                                    Overall())
                                                .time ??
                                            Time())
                                        .totalTime
                                        ?.toString() ??
                                    "0",
                            questionno: (((((testSeriesProvider.testseriesAnalysisModel
                                                                    .performance ??
                                                                Performance())
                                                            .overall ??
                                                        Overall())
                                                    .count ??
                                                Count())
                                            .totalCorrect ??
                                        0) +
                                    ((((testSeriesProvider
                                                                    .testseriesAnalysisModel
                                                                    .performance ??
                                                                Performance())
                                                            .overall ??
                                                        Overall())
                                                    .count ??
                                                Count())
                                            .totalIncorrect ??
                                        0) +
                                    ((((testSeriesProvider.testseriesAnalysisModel
                                                                    .performance ??
                                                                Performance())
                                                            .overall ??
                                                        Overall())
                                                    .count ??
                                                Count())
                                            .totalUnanswered ??
                                        0) +
                                    ((((testSeriesProvider.testseriesAnalysisModel
                                                                    .performance ??
                                                                Performance())
                                                            .overall ??
                                                        Overall())
                                                    .count ??
                                                Count())
                                            .totalUnattended ??
                                        0))
                                .toString(),
                          ),
                          const SizedBox(height: 10),

                          /// View Ranklist Button
                          CustomButton(
                            text: 'View Ranklist',
                            color: AppColors.primaryOrange,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TestSeriesRankList(
                                          testId: widget.testid,
                                          maxMark:
                                              "${((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).maxMarks}",
                                        ))),
                            textcolor: AppColors.white,
                          ),
                          const SizedBox(height: 20),

                          /// Test Detail Widgets (2 rows of 2)
                          Column(
                            children: [
                              Column(children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: TestDetailWidget(
                                            label: "Score",
                                            value:
                                                '${((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).score}/${((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).maxMarks}',
                                            icon: Ph.star_fill,
                                            size: 80,
                                            color: AppColors.primaryBlue)),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: TestDetailWidget(
                                            label: "Average Time",
                                            value:
                                                '${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).averageTimePerQuestion ?? 0.0)} sec',
                                            icon: Ph.clock_fill,
                                            size: 80,
                                            color: AppColors.primaryGreen))
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                        child: TestDetailWidget(
                                            label: "Accuracy",
                                            value:
                                                '${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).accuracy ?? 0)}%',
                                            icon: Ph.target_bold,
                                            size: 100,
                                            color: AppColors.primaryOrange)),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: TestDetailWidget(
                                            label: "Rank",
                                            value: ((testSeriesProvider
                                                                .testseriesAnalysisModel
                                                                .performance ??
                                                            Performance())
                                                        .rank ??
                                                    0)
                                                .toString(),
                                            icon: Ion.md_trophy,
                                            size: 100,
                                            color: AppColors.primaryRed))
                                  ],
                                )
                              ]),
                              const SizedBox(height: 20),

                              /// Score Analysis (Bar Chart)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  "Overall Analysis",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: AppColors.grey)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 230,
                                            child: SfCartesianChart(
                                              primaryXAxis: CategoryAxis(),
                                              primaryYAxis: NumericAxis(),
                                              series: <CartesianSeries<
                                                  ChartData, String>>[
                                                ColumnSeries<ChartData, String>(
                                                  dataSource: [
                                                    ChartData(
                                                        "Correct",
                                                        (((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ??
                                                                            Overall())
                                                                        .count ??
                                                                    Count())
                                                                .totalCorrect ??
                                                            0,
                                                        AppColors.primaryGreen),
                                                    ChartData(
                                                        "Incorrect",
                                                        (((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ??
                                                                            Overall())
                                                                        .count ??
                                                                    Count())
                                                                .totalIncorrect ??
                                                            0,
                                                        AppColors.primaryRed),
                                                    ChartData(
                                                        "Unanswered",
                                                        (((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ??
                                                                            Overall())
                                                                        .count ??
                                                                    Count())
                                                                .totalUnanswered ??
                                                            0,
                                                        AppColors.primaryBlue),
                                                    ChartData(
                                                        "Unattended",
                                                        (((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ??
                                                                            Overall())
                                                                        .count ??
                                                                    Count())
                                                                .totalUnattended ??
                                                            0,
                                                        AppColors.grey),
                                                  ],
                                                  xValueMapper:
                                                      (ChartData d, _) =>
                                                          d.category,
                                                  yValueMapper:
                                                      (ChartData d, _) =>
                                                          d.value,
                                                  pointColorMapper:
                                                      (ChartData d, _) =>
                                                          d.color,
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                          isVisible: true),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: AppColors
                                                          .primaryGreen,
                                                    ),
                                                    width: 12,
                                                    height: 12,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text("Correct:"),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    ((((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ??
                                                                            Overall())
                                                                        .count ??
                                                                    Count())
                                                                .totalIncorrect ??
                                                            0)
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .primaryGreen),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color:
                                                          AppColors.primaryRed,
                                                    ),
                                                    width: 12,
                                                    height: 12,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text("Incorrect:"),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                      ((((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ??
                                                                              Overall())
                                                                          .count ??
                                                                      Count())
                                                                  .totalIncorrect ??
                                                              0)
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .primaryRed))
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color:
                                                          AppColors.primaryBlue,
                                                    ),
                                                    width: 12,
                                                    height: 12,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text("Unanswered:"),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).count ?? Count()).totalUnanswered ?? 0}",
                                                    style: TextStyle(
                                                        color: AppColors.black),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: AppColors.grey,
                                                    ),
                                                    width: 12,
                                                    height: 12,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text("Unattended:"),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).count ?? Count()).totalUnattended ?? 0}",
                                                    style: TextStyle(
                                                        color: AppColors.black),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  )),

                              const SizedBox(height: 20),

                              /// Test Summary
                              const Text("Test Summary",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(height: 10),
                              Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.borderGrey,
                                      border: Border.all(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        _buildSummaryRow("Total time taken:",
                                            "${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).time ?? Time()).totalTime ?? 0} sec"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Number of Qtns Correctly Answered:",
                                            "${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).count ?? Count()).totalCorrect ?? 0}"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Time taken for correct Answer:",
                                            "${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).time ?? Time()).correctTime ?? 0} sec"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Number of Qtns Incorrectly Answered:",
                                            "${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).count ?? Count()).totalIncorrect ?? 0}"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Time taken for incorrect Answer:",
                                            "${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).time ?? Time()).incorrectTime ?? 0} sec"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Number of Qtns Unanswered:",
                                            "${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).count ?? Count()).totalUnanswered ?? 0}"),
                                        _buildSummaryRow(
                                            "Avg time taken for unanswered Answer:",
                                            "${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).time ?? Time()).unansweredTime ?? 0} sec"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Number of Qtns Unattended:",
                                            "${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).count ?? Count()).totalUnattended ?? 0}"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Avg time taken for unattended Answer:",
                                            "${(((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).time ?? Time()).unattendedTime ?? 0} sec"),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          /// Subject vs Time Analysis (Pie Charts)
                          const Text("Subject vs Time Analysis",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 10),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            itemCount: ((testSeriesProvider
                                                .testseriesAnalysisModel
                                                .performance ??
                                            Performance())
                                        .subjectAnalysis ??
                                    [])
                                .length,
                            itemBuilder: (context, index) {
                              final subjectData = ((testSeriesProvider
                                              .testseriesAnalysisModel
                                              .performance ??
                                          Performance())
                                      .subjectAnalysis ??
                                  [])[index];

                              return _buildPieChartTime(subjectData);
                            },
                          ),

                          const SizedBox(height: 20),

                          /// Subject vs Score (Pie Charts)
                          const Text("Subject vs Score Analysis",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 10),

                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            itemCount: ((testSeriesProvider
                                                .testseriesAnalysisModel
                                                .performance ??
                                            Performance())
                                        .subjectAnalysis ??
                                    [])
                                .length,
                            itemBuilder: (context, index) {
                              final subjectData = ((testSeriesProvider
                                              .testseriesAnalysisModel
                                              .performance ??
                                          Performance())
                                      .subjectAnalysis ??
                                  [])[index];

                              return _buildPieChartScore(subjectData);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildPieChartScore(SubjectAnalysis subjectData) {
    Count subjectCountData = subjectData.count ?? Count();
    List<ChartData> subjectChartData = [
      ChartData("Correct", subjectCountData.totalCorrect ?? 0,
          AppColors.primaryGreen),
      ChartData("Incorrect", subjectCountData.totalIncorrect ?? 0,
          AppColors.primaryRed),
      ChartData("Unanswered", subjectCountData.totalUnanswered ?? 0,
          AppColors.primaryBlue),
      ChartData(
          "Unattended", subjectCountData.totalUnattended ?? 0, AppColors.grey)
    ];

    return Container(
      height: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey),
      ),
      child: Row(
        children: [
          // Title + Legends
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    subjectData.subject ?? "Subject Name",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 👉 Legends
                  ...subjectChartData.map((d) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: d.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            d.category,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Pie Chart
          Expanded(
            child: Center(
              child: SfCircularChart(
                legend: Legend(isVisible: false),
                series: <PieSeries<ChartData, String>>[
                  PieSeries<ChartData, String>(
                    dataSource: subjectChartData,
                    xValueMapper: (ChartData d, _) => d.category,
                    yValueMapper: (ChartData d, _) => d.value,
                    pointColorMapper: (ChartData d, _) => d.color,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                    ),
                    radius: "70%",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChartTime(SubjectAnalysis subjectData) {
    Time subjectTimeData = subjectData.time ?? Time();
    List<ChartData> subjectChartData = [
      ChartData(
          "Correct", subjectTimeData.correctTime ?? 0, AppColors.primaryGreen),
      ChartData("Incorrect", subjectTimeData.incorrectTime ?? 0,
          AppColors.primaryRed),
      ChartData("Unanswered", subjectTimeData.unansweredTime ?? 0,
          AppColors.primaryBlue),
      ChartData(
          "Unattended", subjectTimeData.unattendedTime ?? 0, AppColors.grey)
    ];

    return Container(
      height: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey),
      ),
      child: Row(
        children: [
          // Title + Legends
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    subjectData.subject ?? "Subject Name",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 👉 Legends
                  ...subjectChartData.map((d) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: d.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            d.category,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Pie Chart
          Expanded(
            child: Center(
              child: SfCircularChart(
                legend: Legend(isVisible: false),
                series: <PieSeries<ChartData, String>>[
                  PieSeries<ChartData, String>(
                    dataSource: subjectChartData,
                    xValueMapper: (ChartData d, _) => d.category,
                    yValueMapper: (ChartData d, _) => d.value,
                    pointColorMapper: (ChartData d, _) => d.color,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                    ),
                    radius: "70%",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable Summary Row
  Widget _buildSummaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 14)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildLegendItem(String label, int value, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(
        "$label: $value",
        style: const TextStyle(fontSize: 14),
      ),
    ],
  );
}

class ChartData {
  final String category;
  final int value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}
