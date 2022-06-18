import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MatchAnalysis extends StatelessWidget {
  const MatchAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<ChartData> data = [ChartData(x: 100, y: 1),
      ChartData(x: 200, y: 2),
      ChartData(x: 300, y: 3)];

    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    series: <ChartSeries>[
                      BarSeries<ChartData, double>(
                          dataSource: data,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      )
                    ]
                )
            )
        )
    );
  }
}

class ChartData {
  final double x;
  final double y;

  const ChartData({required this.x, required this.y});
}
