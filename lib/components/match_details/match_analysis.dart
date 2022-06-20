import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../model/match/match_participant.dart';
import '../../model/match/match.dart';

class MatchAnalysis extends StatelessWidget {
  final Match match;
  final MatchParticipant matchParticipant;
  static const Color winColor = Color(0xff456bf8);
  static const Color looseColor = Color(0xffff4040);

  const MatchAnalysis({Key? key,
    required this.match,
    required this.matchParticipant}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<ChartData> damageDealtData = buildTotalDamageDealtToChampions();
    return Column(
              children: [
                buildDataBar(damageDealtData),
              ],
          );
  }

  List<ChartData> buildTotalDamageDealtToChampions() {
    List<ChartData> participants = match.participants
        .map((e) => ChartData(x: e.championName, y: e.totalDamageDealtToChampions, color: (e.win ? winColor : looseColor)))
        .toList();
    participants.sort((a, b) => a.y.compareTo(b.y));
    return participants;
  }

  SfCartesianChart buildDataBar(List<ChartData> data) {
    return SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(isVisible: true),
          primaryYAxis: NumericAxis(isVisible: false),
          series: <ChartSeries>[
            BarSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              pointColorMapper: (ChartData data, _) => data.color,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            )
          ]
      );
  }
}

class ChartData {
  final String x;
  final int y;
  final Color color;

  const ChartData({required this.x, required this.y, required this.color});
}
