import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_analysis_model.dart';
import 'package:zephyr/features/chapter_details/provider/enrolled_chapter_details_provider.dart';
import 'package:zephyr/features/chapter_details/screens/multi_radial_bar_chart.dart';
import 'package:zephyr/features/enrolled_courses/provider/enrolled_course_provider.dart';

class ChapterAnalysisScreen extends StatefulWidget {
  const ChapterAnalysisScreen({super.key});

  @override
  State<ChapterAnalysisScreen> createState() => _ChapterAnalysisScreenState();

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
                DoughnutSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData d, _) => d.label,
                  yValueMapper: (_ChartData d, _) => d.value,
                  pointColorMapper: (_ChartData d, _) => d.color,
                  radius: "75%",
                  innerRadius: "72%",
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                ),
              ],
              annotations: <CircularChartAnnotation>[
                          CircularChartAnnotation(
                            widget: Text(
                              "${completed.toInt()}%",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          )
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
              _LegendText(
                  label: "Completed",
                  value: "${completed.toInt()}%",
                  color: completedColor),
              const SizedBox(height: 4),
              _LegendText(
                  label: "Incomplete",
                  value: "${notCompleted.toInt()}%",
                  color: AppColors.lightGrey),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChapterAnalysisScreenState extends State<ChapterAnalysisScreen> {
  EnrolledChapterDetailsProvider enrolledChapterDetailsProvider =
      EnrolledChapterDetailsProvider();
  @override
  void initState() {
    super.initState();
    loadChapterAnalysis();
  }

  Future<void> loadChapterAnalysis() async {
    final loadProvider = context.read<EnrolledChapterDetailsProvider>();
    final enrollmentLoadProvider = context.read<EnrolledCourseProvider>();
    await loadProvider.fetchEnrolledChapterAnalysis(
        context: context,
        enrollmentId:
            (enrollmentLoadProvider.selectedEnrollment.enrollmentId ?? "0")
                .toString(),
        courseSubjectId:
            (loadProvider.selectedSubject.courseSubjectId ?? 0).toString(),
        courseChapterId:
            (loadProvider.selectedChapter.courseChapterId ?? 0).toString());
  }

  @override
  Widget build(BuildContext context) {
    enrolledChapterDetailsProvider = context.watch<EnrolledChapterDetailsProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: BackButton(),
        title: Row(
          children: const [
            Icon(Icons.analytics, color: AppColors.black),
            SizedBox(width: 8),
            Text(
              "Chapter Analysis",
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: enrolledChapterDetailsProvider.isAnalysisLoading
      ? Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
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
                              _ChartData(
                                  'Completed', (enrolledChapterDetailsProvider.enrolledChapterAnalysis.totalAccessPercentage ?? 0.0).toInt().toDouble(), AppColors.primaryBlue),
                              _ChartData(
                                  'Not Completed', (100 - (enrolledChapterDetailsProvider.enrolledChapterAnalysis.totalAccessPercentage ?? 0.0).toInt()).toDouble(), AppColors.lightGrey),
                            ],
                            xValueMapper: (_ChartData data, _) => data.label,
                            yValueMapper: (_ChartData data, _) => data.value,
                            pointColorMapper: (_ChartData data, _) =>
                                data.color,
                            radius: '100%',
                            innerRadius: '70%',
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: false),
                          )
                        ],
                        annotations: <CircularChartAnnotation>[
                          CircularChartAnnotation(
                            widget: Text("${(enrolledChapterDetailsProvider.enrolledChapterAnalysis.totalAccessPercentage ?? 0.0).toInt()}%",
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
                    children: [
                      _LegendText(
                          label: "Completed",
                          value: "${(enrolledChapterDetailsProvider.enrolledChapterAnalysis.totalAccessPercentage ?? 0.0).toInt()}%",
                          color: AppColors.primaryBlue),
                      _LegendText(
                          label: "Not Completed",
                          value: "${100 - (enrolledChapterDetailsProvider.enrolledChapterAnalysis.totalAccessPercentage ?? 0.0).toInt()}%",
                          color: AppColors.lightGrey),
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
                  child: ChapterAnalysisScreen._buildPieCard(
                    title: "Video",
                    completed: ((enrolledChapterDetailsProvider.enrolledChapterAnalysis.video ?? Video(percentage: 0)).percentage ?? 0).toDouble(),
                    notCompleted: (100 - ((enrolledChapterDetailsProvider.enrolledChapterAnalysis.video ?? Video(percentage: 0)).percentage ?? 0)).toDouble(),
                    completedColor: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ChapterAnalysisScreen._buildPieCard(
                    title: "Study Materials",
                    completed: ((enrolledChapterDetailsProvider.enrolledChapterAnalysis.material ?? Video(percentage: 0)).percentage ?? 0).toDouble(),
                    notCompleted: (100 - ((enrolledChapterDetailsProvider.enrolledChapterAnalysis.material ?? Video(percentage: 0)).percentage ?? 0)).toDouble(),
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
