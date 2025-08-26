import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zephyr/constants/app_constants.dart';

class AnswerStatusRadialChart extends StatelessWidget {
  final List<_ChartData> chartData = [
    _ChartData("Unanswered", 20, AppColors.primaryRed, "20"),
    _ChartData("Wrong", 30, AppColors.primaryOrange, "30"),
    _ChartData("Correct", 50, AppColors.primaryGreen, "50"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
          const Text(
            "Practical Tests",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 12),

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

          const SizedBox(height: 16),

          // Legend texts below chart
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: chartData.map((data) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: data.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${data.label} : ${data.text}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
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
