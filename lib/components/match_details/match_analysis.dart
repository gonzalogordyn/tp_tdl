import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../model/match/match_participant.dart';
import '../../model/match/match.dart';

class MatchAnalysis extends StatelessWidget {
  final Match match;
  final MatchParticipant matchParticipant;

  const MatchAnalysis({Key? key,
    required this.match,
    required this.matchParticipant}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<ChartData> data = _buildTotalDamageDealtToChampions();

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

  List<ChartData> _buildTotalDamageDealtToChampions() {
    List<MatchParticipant> participants = List.from(match.participants);
    participants.sort((a, b) => a.totalDamageDealtToChampions.compareTo(b.totalDamageDealtToChampions));
    return participants.map((e) => ChartData(x: e.championName, y: e.totalDamageDealtToChampions)).toList();
  }
}



class ChartData {
  final String x;
  final int y;

  const ChartData({required this.x, required this.y});
}
