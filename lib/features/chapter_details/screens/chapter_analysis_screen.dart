import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/screens/multi_radial_bar_chart.dart';

class ChapterAnalysisScreen extends StatelessWidget {
  const ChapterAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: AppColors.black),
        title: Row(
          children: const [
            Icon(Icons.analytics, color: AppColors.black),
            SizedBox(width: 8),
            Text(
              "Chapter Analysis",
              style: TextStyle(color:AppColors.black, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ------------------ Complete Analysis ------------------
            Center(
              child: const Text(
                "Overall Analysis",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Center(
                      child: SfCircularChart(
                        series: <CircularSeries>[
                          DoughnutSeries<_ChartData, String>(
                            dataSource: [
                              _ChartData('Completed', 67, AppColors.primaryBlue),
                              _ChartData('Not Completed', 33, AppColors.lightGrey),
                            ],
                            xValueMapper: (_ChartData data, _) => data.label,
                            yValueMapper: (_ChartData data, _) => data.value,
                            pointColorMapper: (_ChartData data, _) => data.color,
                            radius: '100%',
                            innerRadius: '70%',
                            dataLabelSettings: const DataLabelSettings(isVisible: false),
                          )
                        ],
                        annotations: <CircularChartAnnotation>[
                          CircularChartAnnotation(
                            widget: const Text(
                              "67%",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  /// Text below chart
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _LegendText(label: "Completed", value: "67%", color: AppColors.primaryBlue),
                      _LegendText(label: "Not Completed", value: "33%", color: AppColors.lightGrey),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ------------------ Individual Analysis ------------------
            const Center(
              child: Text(
                "Individual Analysis",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildPieCard(
                    title: "Video",
                    completed: 80,
                    notCompleted: 20,
                    completedColor: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPieCard(
                    title: "Study Materials",
                    completed: 70,
                    notCompleted: 30,
                    completedColor: AppColors.primaryOrange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            AnswerStatusRadialChart()
          ],
        ),
      ),
    );
  }

  /// ------------------ Pie Card (Video / Study Material) ------------------
  static Widget _buildPieCard({
    required String title,
    required double completed,
    required double notCompleted,
    required Color completedColor,
  }) {
    final data = [
      _ChartData('Completed', completed, completedColor),
      _ChartData('Not Completed', notCompleted, AppColors.lightGrey),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: SfCircularChart(
              margin: EdgeInsets.zero,
              series: <CircularSeries>[
                PieSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData d, _) => d.label,
                  yValueMapper: (_ChartData d, _) => d.value,
                  pointColorMapper: (_ChartData d, _) => d.color,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.black),
          ),

          /// Completed & Not Completed shown in Column
          const SizedBox(height: 8),
          Column(
            children: [
              _LegendText(label: "Completed", value: "${completed.toInt()}%", color: completedColor),
              const SizedBox(height: 4),
              _LegendText(label: "Incomplete", value: "${notCompleted.toInt()}%", color: AppColors.lightGrey),
            ],
          ),
        ],
      ),
    );
  }
}

/// ------------------ Chart Data Model ------------------
class _ChartData {
  final String label;
  final double value;
  final Color color;

  _ChartData(this.label, this.value, this.color);
}

/// ------------------ Legend Text Widget ------------------
class _LegendText extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _LegendText({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 10, color: color),
        const SizedBox(width: 6),
        Text(
          "$label: $value",
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
