import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const PieChartDemo());
}

class PieChartDemo extends StatelessWidget {
  const PieChartDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Syncfusion Pie Charts")),
        body: const PieChartExamples(),
      ),
    );
  }
}

class PieChartExamples extends StatelessWidget {
  const PieChartExamples({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Apple', 35),
      ChartData('Banana', 28),
      ChartData('Orange', 34),
      ChartData('Grapes', 32),
      ChartData('Others', 10),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("1. Basic Pie Chart",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SfCircularChart(
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
            )
          ],
        ),

        const Text("2. Doughnut Chart",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SfCircularChart(
          series: <CircularSeries>[
            DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              innerRadius: '60%',
            )
          ],
        ),

        const Text("3. Semi Pie Chart",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SfCircularChart(
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              startAngle: 270,
              endAngle: 90,
            )
          ],
        ),

        const Text("4. Exploded Pie Chart",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SfCircularChart(
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              explode: true,
              explodeIndex: 1,
            )
          ],
        ),

        const Text("5. Grouped Pie Chart",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SfCircularChart(
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              groupMode: CircularChartGroupMode.value,
              groupTo: 20, // group values < 20
            )
          ],
        ),

        const Text("6. Pie Chart with Data Labels",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SfCircularChart(
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
              ),
            )
          ],
        ),

        const Text("7. 3D Pie Chart",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SfCircularChart(
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
            )
          ],
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.category, this.value);
  final String category;
  final double value;
}
