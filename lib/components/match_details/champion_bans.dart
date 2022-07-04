import 'package:flutter/material.dart';
import '../../model/live_match/live_match.dart';
import '../../model_parsers/live_match_parser.dart';
import '../../views/live_game.dart';
import '../../model/live_match/champion_portrait.dart';

class ChampionBans extends StatelessWidget {
  final List<int> bannedChampionsIds;
  final LiveMatch liveMatch;
  final Map <String, dynamic> champDataJson;

  const ChampionBans({Key? key, required this.bannedChampionsIds, required this.liveMatch, required this.champDataJson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(bannedChampionsIds.isNotEmpty) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Bans: ", style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ChampionPortrait(championName: getChampionNameFromId(
                champDataJson, liveMatch.bannedChampionsIds[0]), imageSize: 30),
            SizedBox(width: 1),
            ChampionPortrait(championName: getChampionNameFromId(
                champDataJson, liveMatch.bannedChampionsIds[1]), imageSize: 30),
            SizedBox(width: 1),
            ChampionPortrait(championName: getChampionNameFromId(
                champDataJson, liveMatch.bannedChampionsIds[2]), imageSize: 30),
            SizedBox(width: 1),
            ChampionPortrait(championName: getChampionNameFromId(
                champDataJson, liveMatch.bannedChampionsIds[3]), imageSize: 30),
            SizedBox(width: 1),
            ChampionPortrait(championName: getChampionNameFromId(
                champDataJson, liveMatch.bannedChampionsIds[4]), imageSize: 30),
          ],
        );
    }
    else{
        return SizedBox(
          width: 100,
        );
    }
  }
}
