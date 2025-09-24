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
  final String date;
  const TestReviewScreen(
      {super.key,
      required this.type,
      required this.testid,
      required this.title,
      required this.date});

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
                            date: formatDate(widget.date, "dd/MM/yyyy"),
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
                            questionno: "20",
                          ),
                          const SizedBox(height: 10),

                          /// View Ranklist Button
                          CustomButton(
                            text: 'View Ranklist',
                            color: AppColors.primaryOrange,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TestSeriesRankList(testId: widget.testid))),
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
                                                '${((testSeriesProvider.testseriesAnalysisModel.performance ?? Performance()).overall ?? Overall()).score}/100',
                                            icon: Ph.star_fill,
                                            size: 80,
                                            color: AppColors.primaryBlue)),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: TestDetailWidget(
                                            label: "Average Time",
                                            value: '${(((((testSeriesProvider.testseriesAnalysisModel
                                                                .performance ??
                                                            Performance())
                                                        .overall ??
                                                    Overall())
                                                .time ??
                                            Time())
                                        .totalTime ?? 0)/4)} sec',
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
                                            value: '25%',
                                            icon: Ph.target_bold,
                                            size: 100,
                                            color: AppColors.primaryOrange)),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: TestDetailWidget(
                                            label: "Rank",
                                            value: ((testSeriesProvider.testseriesAnalysisModel
                                                                .performance ??
                                                            Performance()).rank ?? 0).toString(),
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
                                  "Score Analysis",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 15,
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
                                        SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                          height: 250,
                                          child: SfCartesianChart(
                                            primaryXAxis: CategoryAxis(),
                                            primaryYAxis: NumericAxis(),
                                            series: <CartesianSeries<ChartData,
                                                String>>[
                                              ColumnSeries<ChartData, String>(
                                                dataSource: [
                                                  ChartData("Correct", 20,
                                                      AppColors.primaryGreen),
                                                  ChartData("Incorrect", 5,
                                                      AppColors.primaryRed),
                                                  ChartData("Reviewed", 16,
                                                      AppColors.primaryBlue),
                                                  ChartData("Unattended", 5,
                                                      AppColors.grey),
                                                ],
                                                xValueMapper:
                                                    (ChartData d, _) =>
                                                        d.category,
                                                yValueMapper:
                                                    (ChartData d, _) => d.value,
                                                pointColorMapper:
                                                    (ChartData d, _) => d.color,
                                                dataLabelSettings:
                                                    const DataLabelSettings(
                                                        isVisible: true),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  const SizedBox(width: 8),
                                                  const Text("Correct:"),
                                                  Text(
                                                    "20",
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
                                                  const SizedBox(width: 8),
                                                  const Text("Incorrect:"),
                                                  Text(" 20",
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
                                                  const SizedBox(width: 8),
                                                  const Text("Reviewed:"),
                                                  Text(
                                                    " 16",
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .primaryBlue),
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
                                                  const SizedBox(width: 8),
                                                  const Text("Unattended:"),
                                                  Text(
                                                    " 5",
                                                    style: TextStyle(
                                                        color: AppColors.black),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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
                                        _buildSummaryRow(
                                            "Total time taken:", "34 min"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Number of Qtns Correctly Answered:",
                                            "15"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Avg time taken for correct Answer:",
                                            "1.4 sec"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Number of Qtns Incorrectly Answered:",
                                            "6"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Avg time taken for incorrect Answer:",
                                            "2.1 sec"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Number of Qtns Reviewed only:",
                                            "4"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Avg time taken for reviewed Answer:",
                                            "34 min"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Number of Qtns Unattended:", "5"),
                                        Divider(),
                                        _buildSummaryRow(
                                            "Avg time taken for unattended Answer:",
                                            "34 min"),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Subject vs Time Analysis (Pie Charts)
                    const Text("Subject vs Time Analysis",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 405,
                      child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 7,
                              ),
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) =>
                              _buildPieChart("Biology", [
                                ChartData(
                                    "Correct", 30, AppColors.primaryGreen),
                                ChartData(
                                    "Incorrect", 40, AppColors.primaryRed),
                                ChartData(
                                    "Reviewed", 20, AppColors.primaryBlue),
                                ChartData("Unattended", 10, AppColors.grey),
                              ])),
                    ),

                    const SizedBox(height: 20),

                    /// Subject/ Section Wise Score (Pie Charts)
                    const Text("Subject/ Section Wise Score",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 405,
                      child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 7,
                              ),
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (context, index) =>
                              _buildPieChart("Biology", [
                                ChartData(
                                    "Correct", 30, AppColors.primaryGreen),
                                ChartData(
                                    "Incorrect", 40, AppColors.primaryRed),
                                ChartData(
                                    "Reviewed", 20, AppColors.primaryBlue),
                                ChartData("Unattended", 10, AppColors.grey),
                              ])),
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
      ),
    );
  }

  /// Reusable Pie Chart Widget
  Widget _buildPieChart(String title, List<ChartData> data) {
    return Container(
      height: 405,
      padding: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey)),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            width: 260,
            child: SfCircularChart(
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                orientation:
                    LegendItemOrientation.horizontal, // 🔹 arrange horizontally
                overflowMode:
                    LegendItemOverflowMode.wrap, // 🔹 wrap into new row
                itemPadding: 10, // 🔹 spacing between items
              ),
              series: <PieSeries<ChartData, String>>[
                PieSeries<ChartData, String>(
                  dataSource: data,
                  xValueMapper: (ChartData d, _) => d.category,
                  yValueMapper: (ChartData d, _) => d.value,
                  pointColorMapper: (ChartData d, _) => d.color,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                  ),
                  radius: "60%",
                ),
              ],
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
