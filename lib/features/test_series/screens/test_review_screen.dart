import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ion.dart';
import 'package:iconify_flutter_plus/icons/ph.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zephyr/common/functions/common_functions.dart';
import 'package:zephyr/common/provider/user_details_provider.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/test_series/model/testseries_analysis_model.dart';
import 'package:zephyr/features/test_series/provider/test_series_provider.dart';
import 'package:zephyr/features/test_series/screens/test_series_rank_list.dart';
import 'package:zephyr/features/test_series/screens/test_series_solutions_screen.dart';

class TestReviewScreen extends StatefulWidget {
  final String type;
  final String testid;
  final String title;
  const TestReviewScreen({
    super.key,
    required this.type,
    required this.testid,
    required this.title,
  });

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
      context: context,
      testId: widget.testid,
    );
  }

  @override
  Widget build(BuildContext context) {
    userDetailsProvider = context.watch<UserDetailsProvider>();
    testSeriesProvider = context.watch<TestSeriesProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Test Analysis",
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryBlue,
                side: BorderSide(color: AppColors.primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.visibility,
                  color: AppColors.primaryBlue, size: 20),
              label: const Text("View Solution"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TestSeriesSolutionsScreen(
                    type: widget.type,
                    testid: widget.testid,
                    userid: userDetailsProvider.userDetails.id.toString(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: testSeriesProvider.isAnalysisLoading
            ? const Center(child: CircularProgressIndicator())
            : !(testSeriesProvider.isResultPublished)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lottie/chart.json", height: 200),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Test Analysis not yet published.\nPlease try again later!",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    // padding:
                    //     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Modern Card for Report
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Column(
                            children: [
                              _ModernTestReportCard(
                                title: widget.title,
                                date: formatDate(
                                  '${(testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).submitTime}',
                                  "dd/MM/yyyy hh:mm a",
                                ),
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
                                questionno: (((((testSeriesProvider
                                                                        .testseriesAnalysisModel.performance ??
                                                                    Performance())
                                                                .overall ??
                                                            Overall())
                                                        .count ??
                                                    Count())
                                                .totalCorrect ??
                                            0) +
                                        ((((testSeriesProvider.testseriesAnalysisModel
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
                                isPassed: ((testSeriesProvider
                                                        .testseriesAnalysisModel
                                                        .performance ??
                                                    Performance())
                                                .overall ??
                                            Overall())
                                        .pass ??
                                    true,
                              ),
                              const SizedBox(height: 18),

                              // Modern Ranklist Button
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 40,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryOrange,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                  icon: const Icon(Icons.leaderboard, size: 20),
                                  label: const Text("View Ranklist",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TestSeriesRankList(
                                        testId: widget.testid,
                                        maxMark:
                                            "${((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).maxMarks}",
                                        testTitle: widget.title,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Modern Stats Grid
                              _ModernStatsGrid(
                                  testSeriesProvider: testSeriesProvider),

                              const SizedBox(height: 20),

                              // Modern Bar Chart Card
                              _ModernBarChartCard(
                                  testSeriesProvider: testSeriesProvider),

                              const SizedBox(height: 20),

                              // Modern Summary Card
                              _ModernSummaryCard(
                                  testSeriesProvider: testSeriesProvider),

                              const SizedBox(height: 20),

                              // Subject vs Time Analysis
                              Text(
                                "Subject vs Time Analysis",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 350, // Adjust height as needed for card size
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            scrollDirection: Axis.horizontal,
                            itemCount: ((testSeriesProvider
                                                .testseriesAnalysisModel
                                                .performance ??
                                            Performance())
                                        .subjectAnalysis ??
                                    [])
                                .length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 18),
                            itemBuilder: (context, index) {
                              final subjectData = ((testSeriesProvider
                                              .testseriesAnalysisModel
                                              .performance ??
                                          Performance())
                                      .subjectAnalysis ??
                                  [])[index];
                              return SizedBox(
                                width: 320, // Adjust width for each card
                                child: _ModernPieChartCard(
                                  subjectData: subjectData,
                                  isTime: true,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Subject vs Score Analysis
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Subject vs Score Analysis",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 350, // Adjust height as needed for card size
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            scrollDirection: Axis.horizontal,
                            itemCount: ((testSeriesProvider
                                                .testseriesAnalysisModel
                                                .performance ??
                                            Performance())
                                        .subjectAnalysis ??
                                    [])
                                .length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 18),
                            itemBuilder: (context, index) {
                              final subjectData = ((testSeriesProvider
                                              .testseriesAnalysisModel
                                              .performance ??
                                          Performance())
                                      .subjectAnalysis ??
                                  [])[index];
                              return SizedBox(
                                width: 320, // Adjust width for each card
                                child: _ModernPieChartCard(
                                  subjectData: subjectData,
                                  isTime: false,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}

// Modern Report Card
class _ModernTestReportCard extends StatelessWidget {
  final String title;
  final String date;
  final String duration;
  final String questionno;
  final bool isPassed;

  const _ModernTestReportCard({
    required this.title,
    required this.date,
    required this.duration,
    required this.questionno,
    required this.isPassed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor:
                  isPassed ? AppColors.primaryGreen : AppColors.primaryRed,
              child: Icon(
                isPassed ? Icons.check_circle : Icons.cancel,
                color: Colors.white,
                size: 38,
              ),
            ),
            const SizedBox(width: 22),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 15,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16, color: AppColors.grey),
                          const SizedBox(width: 6),
                          Text(date, style: theme.textTheme.bodySmall),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16, color: AppColors.grey),
                          const SizedBox(width: 6),
                          Text("$duration sec",
                              style: theme.textTheme.bodySmall),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.timer, size: 16, color: AppColors.grey),
                          const SizedBox(width: 6),
                          Text("$questionno Questions",
                              style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Icon(Icons.calendar_today,
                  //         size: 16, color: AppColors.grey),
                  //     const SizedBox(width: 6),
                  //     Text(date, style: theme.textTheme.bodySmall),
                  //     const SizedBox(width: 16),
                  //     Icon(Icons.timer, size: 16, color: AppColors.grey),
                  //     const SizedBox(width: 6),
                  //     Text("$duration sec", style: theme.textTheme.bodySmall),
                  //   ],
                  // ),
                  // const SizedBox(height: 8),
                  // Row(
                  //   children: [
                  //     Icon(Icons.help_outline, size: 16, color: AppColors.grey),
                  //     const SizedBox(width: 6),
                  //     Text("$questionno Questions",
                  //         style: theme.textTheme.bodySmall),
                  //   ],
                  // ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPassed
                          ? AppColors.primaryGreen.withOpacity(0.1)
                          : AppColors.primaryRed.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isPassed ? "Passed" : "Failed",
                      style: TextStyle(
                        color: isPassed
                            ? AppColors.primaryGreen
                            : AppColors.primaryRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Modern Stats Grid
class _ModernStatsGrid extends StatelessWidget {
  final TestSeriesProvider testSeriesProvider;
  const _ModernStatsGrid({required this.testSeriesProvider});

  @override
  Widget build(BuildContext context) {
    final overall = (testSeriesProvider.testseriesAnalysisModel.performance ??
                Performance())
            .overall ??
        Overall();
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 90,
            crossAxisSpacing: 18,
            mainAxisSpacing: 12,
          ),
          children: [
            _ModernStatTile(
              label: "Score",
              value: '${overall.score}/${overall.maxMarks}',
              icon: Ph.star_fill,
              color: AppColors.primaryBlue,
            ),
            _ModernStatTile(
              label: "Average Time",
              value: '${overall.averageTimePerQuestion ?? 0.0} sec',
              icon: Ph.clock_fill,
              color: AppColors.primaryGreen,
            ),
            _ModernStatTile(
              label: "Accuracy",
              value: '${overall.accuracy ?? 0}%',
              icon: Ph.target_bold,
              color: AppColors.primaryOrange,
            ),
            _ModernStatTile(
              label: "Rank",
              value: ((testSeriesProvider.testseriesAnalysisModel.performance ??
                              Performance())
                          .rank ??
                      0)
                  .toString(),
              icon: Ion.md_trophy,
              color: AppColors.primaryRed,
            ),
          ],
        ),
      ),
    );
  }
}

class _ModernStatTile extends StatelessWidget {
  final String label;
  final String value;
  final dynamic icon;
  final Color color;
  const _ModernStatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 22,
            child: Iconify(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label,
                    style:
                        const TextStyle(fontSize: 13, color: Colors.black54)),
                const SizedBox(height: 4),
                Text(value,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Modern Bar Chart Card
class _ModernBarChartCard extends StatelessWidget {
  final TestSeriesProvider testSeriesProvider;
  const _ModernBarChartCard({required this.testSeriesProvider});

  @override
  Widget build(BuildContext context) {
    final overall = (testSeriesProvider.testseriesAnalysisModel.performance ??
                Performance())
            .overall ??
        Overall();
    final count = overall.count ?? Count();
    final chartData = [
      ChartData("Correct", count.totalCorrect ?? 0, AppColors.primaryGreen),
      ChartData("Incorrect", count.totalIncorrect ?? 0, AppColors.primaryRed),
      ChartData(
          "Unanswered", count.totalUnanswered ?? 0, AppColors.primaryBlue),
      ChartData("Unattended", count.totalUnattended ?? 0, AppColors.grey),
    ];

    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Overall Analysis",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 18),
            SizedBox(
              height: 220,
              child: SfCartesianChart(
                margin: EdgeInsets.zero,
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(width: 0.5),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10, // Reduced font size
                  ),
                ),
                primaryYAxis: NumericAxis(
                  majorGridLines: const MajorGridLines(width: 0.2),
                  axisLine: const AxisLine(width: 0.5),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10, // Reduced font size
                  ),
                ),
                series: <CartesianSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData d, _) => d.category,
                    yValueMapper: (ChartData d, _) => d.value,
                    pointColorMapper: (ChartData d, _) => d.color,
                    borderRadius: BorderRadius.circular(8),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(
                          fontSize: 10), // Reduced data label font size
                    ),
                    width: 0.4, // Reduced width (default is 0.7)
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 18,
              runSpacing: 8,
              children: [
                _buildLegendItem(
                    "Correct", count.totalCorrect ?? 0, AppColors.primaryGreen),
                _buildLegendItem("Incorrect", count.totalIncorrect ?? 0,
                    AppColors.primaryRed),
                _buildLegendItem("Unanswered", count.totalUnanswered ?? 0,
                    AppColors.primaryBlue),
                _buildLegendItem(
                    "Unattended", count.totalUnattended ?? 0, AppColors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Modern Summary Card
class _ModernSummaryCard extends StatelessWidget {
  final TestSeriesProvider testSeriesProvider;
  const _ModernSummaryCard({required this.testSeriesProvider});

  @override
  Widget build(BuildContext context) {
    final overall = (testSeriesProvider.testseriesAnalysisModel.performance ??
                Performance())
            .overall ??
        Overall();
    final count = overall.count ?? Count();
    final time = overall.time ?? Time();

    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Test Summary",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            Row(
              children: [
                // Score Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryRow("Total Questions",
                          "${(count.totalCorrect ?? 0) + (count.totalIncorrect ?? 0) + (count.totalUnanswered ?? 0) + (count.totalUnattended ?? 0)}"),
                      _buildSummaryRow("Correct", "${count.totalCorrect ?? 0}"),
                      _buildSummaryRow(
                          "Incorrect", "${count.totalIncorrect ?? 0}"),
                      _buildSummaryRow(
                          "Unanswered", "${count.totalUnanswered ?? 0}"),
                      _buildSummaryRow(
                          "Unattended", "${count.totalUnattended ?? 0}"),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Time Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryRow(
                          "Total Time", "${time.totalTime ?? 0} s"),
                      _buildSummaryRow(
                          "Correct Time", "${time.correctTime ?? 0} s"),
                      _buildSummaryRow(
                          "Incorrect Time", "${time.incorrectTime ?? 0} s"),
                      _buildSummaryRow(
                          "Unanswered Time", "${time.unansweredTime ?? 0} s"),
                      _buildSummaryRow(
                          "Unattended Time", "${time.unattendedTime ?? 0} s"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(title,
                  style: const TextStyle(fontSize: 14, color: Colors.black54))),
          Text(value,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// Modern Pie Chart Card
class _ModernPieChartCard extends StatelessWidget {
  final SubjectAnalysis subjectData;
  final bool isTime;
  const _ModernPieChartCard({required this.subjectData, required this.isTime});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chartData = isTime
        ? [
            ChartData("Correct", (subjectData.time ?? Time()).correctTime ?? 0,
                AppColors.primaryGreen),
            ChartData(
                "Incorrect",
                (subjectData.time ?? Time()).incorrectTime ?? 0,
                AppColors.primaryRed),
            ChartData(
                "Unanswered",
                (subjectData.time ?? Time()).unansweredTime ?? 0,
                AppColors.primaryBlue),
            ChartData(
                "Unattended",
                (subjectData.time ?? Time()).unattendedTime ?? 0,
                AppColors.grey),
          ]
        : [
            ChartData(
                "Correct",
                (subjectData.count ?? Count()).totalCorrect ?? 0,
                AppColors.primaryGreen),
            ChartData(
                "Incorrect",
                (subjectData.count ?? Count()).totalIncorrect ?? 0,
                AppColors.primaryRed),
            ChartData(
                "Unanswered",
                (subjectData.count ?? Count()).totalUnanswered ?? 0,
                AppColors.primaryBlue),
            ChartData(
                "Unattended",
                (subjectData.count ?? Count()).totalUnattended ?? 0,
                AppColors.grey),
          ];

    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              subjectData.subject ?? "Subject Name",
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            // Pie Chart
            SizedBox(
              height: 200,
              child: SfCircularChart(
                margin: EdgeInsets.zero,
                legend: Legend(isVisible: false),
                series: <DoughnutSeries<ChartData, String>>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData d, _) => d.category,
                    yValueMapper: (ChartData d, _) => d.value,
                    pointColorMapper: (ChartData d, _) => d.color,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    radius: "80%",
                    innerRadius: "60%",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Legends below the chart
            Wrap(
              spacing: 18,
              runSpacing: 6,
              children: chartData
                  .map(
                    (d) => Row(
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
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
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
        style: const TextStyle(fontSize: 10),
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
