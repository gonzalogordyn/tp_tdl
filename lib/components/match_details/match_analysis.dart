import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MatchAnalysis extends StatelessWidget {
  const MatchAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<ChartData> data = [ChartData(x: "Veigar", y: 1),
      ChartData(x: "Aatrox", y: 2),
      ChartData(x: "Garen", y: 3)];

    return SfCartesianChart(
              title: ChartTitle(text: "Damage done"),
              primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0),
                                         axisLine: AxisLine(width: 0), ),
              primaryYAxis: NumericAxis(majorGridLines: MajorGridLines(width: 0),
                                        axisLine: AxisLine(width: 0)),
        series: <ChartSeries>[
                BarSeries<ChartData, String>(
                    dataSource: data,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                )
              ]
            );
  }
}

class ChartData {
  final String x;
  final double y;

  const ChartData({required this.x, required this.y});
}
