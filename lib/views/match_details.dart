import 'package:flutter/material.dart';
import '../model/summoner_match_info.dart';

class MatchDetails extends StatelessWidget {
  const MatchDetails({Key? key, required this.summonerMatchInfo}) : super(key: key);

  final SummonerMatchInfo summonerMatchInfo;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff263F65),
        body: Center(
          child: Text(
            summonerMatchInfo.toString()
          ),
        )
    );
  }

}