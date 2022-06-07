import 'package:intl/intl.dart';

class SummonerMatchInfo {
  final String? summonerName;
  final String? championName;
  var score;
  var build;
  bool won = false;
  final String? gamemode;
  final int? gameEndTimestamp;
  SummonerMatchInfo({this.summonerName, this.championName, required this.won, this.score, this.build, this.gamemode, this.gameEndTimestamp});

  factory SummonerMatchInfo.fromJson(String summonerPiuud, Map<String, dynamic> data) {
    final summonerJsonIndex = data["info"]["participants"].indexWhere((participant) => participant["puuid"] == summonerPiuud);

    final summonerJson = data["info"]["participants"][summonerJsonIndex];

    final String summonerName = summonerJson["summonerName"];
    final String championName = summonerJson["championName"];
    var score = {
      "kills": summonerJson["kills"],
      "deaths": summonerJson["deaths"],
      "assists": summonerJson["assists"]
    };
    var build = [
      summonerJson["item0"],
      summonerJson["item1"],
      summonerJson["item2"],
      summonerJson["item3"],
      summonerJson["item4"],
      summonerJson["item5"]
    ];

    bool won = summonerJson["nexusLost"] == 0 ? false : true;
    String gamemode = data["info"]["gameMode"];
    int gameEndTimestamp = data["info"]["gameEndTimestamp"];
    return SummonerMatchInfo(summonerName: summonerName, championName: championName, won: won,
        score: score, build: build, gamemode: gamemode, gameEndTimestamp: gameEndTimestamp);
  }

  String getScoreAsString() {
    return "${score["kills"]}/${score["deaths"]}/${score["assists"]}";
  }

  String getKDA() {
    if(score["deaths"] == 0) {
      return "0";
    }

    return ((score["kills"] + score["assists"]) / score["deaths"]).toStringAsFixed(2);
  }

  String getDateAsString() {
    var datetime = DateTime.fromMillisecondsSinceEpoch(gameEndTimestamp!);

    // 24 Hour format:
    return DateFormat('dd/MM/yyyy').format(datetime);
  }
}