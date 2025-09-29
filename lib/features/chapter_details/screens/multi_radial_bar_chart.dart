import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zephyr/constants/app_constants.dart';
import 'package:zephyr/features/chapter_details/model/enrolled_chapter_analysis_model.dart';
import 'package:zephyr/features/chapter_details/provider/enrolled_chapter_details_provider.dart';

class AnswerStatusRadialChart extends StatefulWidget {
  @override
  State<AnswerStatusRadialChart> createState() =>
      _AnswerStatusRadialChartState();
}

class _AnswerStatusRadialChartState extends State<AnswerStatusRadialChart> {
  EnrolledChapterDetailsProvider enrolledChapterDetailsProvider =
      EnrolledChapterDetailsProvider();

  // final List<_ChartData> chartData = [
  //   _ChartData("Unanswered", 20, AppColors.primaryRed, "20"),
  //   _ChartData("Wrong", 30, AppColors.primaryOrange, "30"),
  //   _ChartData("Correct", 50, AppColors.primaryGreen, "50"),
  // ];

  @override
  Widget build(BuildContext context) {
    enrolledChapterDetailsProvider = context.watch();
    final totalCorrect = (((enrolledChapterDetailsProvider
                            .enrolledChapterAnalysis.practiceTotals ??
                        PracticeTotals())
                    .count ??
                Count())
            .totalCorrect ??
        0);
    final totalInorrect = (((enrolledChapterDetailsProvider
                            .enrolledChapterAnalysis.practiceTotals ??
                        PracticeTotals())
                    .count ??
                Count())
            .totalIncorrect ??
        0);
    final totalUnanswered = (((enrolledChapterDetailsProvider
                            .enrolledChapterAnalysis.practiceTotals ??
                        PracticeTotals())
                    .count ??
                Count())
            .totalUnanswered ??
        0);
    final totalUnattended = (((enrolledChapterDetailsProvider
                            .enrolledChapterAnalysis.practiceTotals ??
                        PracticeTotals())
                    .count ??
                Count())
            .totalUnattended ??
        0);
    final totalCount =
        (totalCorrect + totalInorrect + totalUnanswered + totalUnattended) == 0 ? 1 : (totalCorrect + totalInorrect + totalUnanswered + totalUnattended);

    final chartData = [
      _ChartData(
          "Unanswered",
          ((totalUnanswered * 100) / totalCount).toDouble(),
          AppColors.primaryBlue,
          "${((totalUnanswered * 100) / totalCount).toInt()}%"),
      _ChartData(
          "Unattended",
          ((totalUnattended * 100) / totalCount).toDouble(),
          AppColors.primaryOrange,
          "${((totalUnattended * 100) / totalCount).toInt()}%"),
      _ChartData("Incorrect", ((totalInorrect * 100) / totalCount).toDouble(),
          AppColors.primaryRed, "${((totalInorrect * 100) / totalCount).toInt()}%"),
      _ChartData("Correct", ((totalCorrect * 100) / totalCount).toDouble(),
          AppColors.primaryGreen, "${((totalCorrect * 100) / totalCount).toInt()}%"),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Chart
          SizedBox(
            height: 220,
            child: SfCircularChart(
              series: <RadialBarSeries<_ChartData, String>>[
                RadialBarSeries<_ChartData, String>(
                  dataSource: chartData,
                  trackColor: AppColors.lightGrey,
                  gap: '10%',
                  cornerStyle: CornerStyle.bothCurve,
                  maximumValue: 100,
                  xValueMapper: (_ChartData data, _) => data.label,
                  yValueMapper: (_ChartData data, _) => data.value,
                  pointColorMapper: (_ChartData data, _) => data.color,

                  // ✅ Adjust thickness here
                  radius: '100%',
                  innerRadius: '60%', // not too thin, not too thick

                  dataLabelSettings: const DataLabelSettings(
                    isVisible: false,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Text(
            "Practice Tests",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),

          const SizedBox(height: 16),

          // Legend texts below chart
          Wrap(spacing: 30, alignment: WrapAlignment.center, children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 4),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Container(
            //         width: 10,
            //         height: 10,
            //         decoration: BoxDecoration(
            //           color: AppColors.grey,
            //           shape: BoxShape.circle,
            //         ),
            //       ),
            //       const SizedBox(width: 8),
            //       Text(
            //         "Total : ${100}",
            //         style: const TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500,
            //           color: AppColors.black,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            ...List.generate(
                chartData.length,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: chartData[index].color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${chartData[index].label} : ${chartData[index].text}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ))
          ]),
          SizedBox(height: 5,)
        ],
      ),
    );
  }
}

class _ChartData {
  final String label;
  final double value;
  final Color color;
  final String text;

  _ChartData(this.label, this.value, this.color, this.text);
}
