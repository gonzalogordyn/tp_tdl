import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../model/match/match_participant.dart';
import '../../model/match/match.dart';

class MatchAnalysis extends StatelessWidget {
  final Match match;
  final MatchParticipant matchParticipant;
  static const Color winColor = Color(0xff92DEF6);
  static const Color looseColor = Color(0xffFB9191);

  const MatchAnalysis({Key? key,
    required this.match,
    required this.matchParticipant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: SingleChildScrollView(
      child: Column(
        children: [
          buildDataBar("Damage dealt", buildTotalDamageDealtToChampions()),
          buildDataBar("Damage taken", buildDamageTakenToChampions()),
          buildDataBar("Gold earned", buildGoldEarned()),
          buildDataBar("CS", buildCS()),
        ],
      ),
    )
    );
  }

  List<ChartData> buildTotalDamageDealtToChampions() {
    List<ChartData> participants = match.participants
        .map((e) => ChartData(x: e.championName, y: e.totalDamageDealtToChampions, color: (e.win ? winColor : looseColor)))
        .toList();
    participants.sort((a, b) => a.y.compareTo(b.y));
    return participants;
  }

  List<ChartData> buildDamageTakenToChampions() {
    List<ChartData> participants = match.participants
        .map((e) => ChartData(x: e.championName, y: e.totalDamageTaken, color: (e.win ? winColor : looseColor)))
        .toList();
    participants.sort((a, b) => a.y.compareTo(b.y));
    return participants;
  }

  List<ChartData> buildGoldEarned() {
    List<ChartData> participants = match.participants
        .map((e) => ChartData(x: e.championName, y: e.goldEarned, color: (e.win ? winColor : looseColor)))
        .toList();
    participants.sort((a, b) => a.y.compareTo(b.y));
    return participants;
  }

  List<ChartData> buildCS() {
    List<ChartData> participants = match.participants
        .map((e) => ChartData(x: e.championName, y: e.minionsKilled + e.jungleMinionsKilled, color: (e.win ? winColor : looseColor)))
        .toList();
    participants.sort((a, b) => a.y.compareTo(b.y));
    return participants;
  }

  SfCartesianChart buildDataBar(String title, List<ChartData> data) {
    return SfCartesianChart(
          title: ChartTitle(text: title, textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.inter().fontFamily,
            color: Color(0xffffffff),
          )),
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(isVisible: true,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.inter().fontFamily,
                color: Color(0xffffffff),
              )
          ),
          primaryYAxis: NumericAxis(isVisible: false),
          series: <ChartSeries>[
            BarSeries<ChartData, String>(
                dataSource: data,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                pointColorMapper: (ChartData data, _) => data.color,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                dataLabelSettings: DataLabelSettings(isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.top,
                    textStyle:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      color: Color(0xffffffff),
                    )
                )
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
