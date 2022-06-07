import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:test_project/components/MatchPreview.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../SummonerMatchInfo.dart';

class SummonerHistory extends StatefulWidget {
  SummonerHistory({
    Key? key,
  }) : super(key: key);

  @override
  _SummonerHistoryState createState() => _SummonerHistoryState();

}

class _SummonerHistoryState extends State<SummonerHistory> {
  late Future<SummonerMatchInfo> summonerMatchInfo;
  final String summonerPiuud = "Jm1edPNuEnyrMqbf0fEhzHIP6o5KHqUcBxJl8tC7ZGUdEfY1nli8ViVsBp_7mSkp7alrSQ47Y-lwqQ";
  @override
  void initState() {
    super.initState();
    summonerMatchInfo = getMockedInfo(summonerPiuud);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xff003d73),
        child: Column(
            children: <Widget>[
              SizedBox(height:60),
              Text("SUMMONER_NAME", style: TextStyle(color: Colors.white),),
              SizedBox(height:50),
              FutureBuilder<SummonerMatchInfo>(
                  future: summonerMatchInfo,
                  builder: (BuildContext context, AsyncSnapshot<SummonerMatchInfo> snapshot) {
                    if(snapshot.hasData) {
                      return MatchPreview(summonerMatchInfo: snapshot.data!);
                    } else if(snapshot.hasError){
                      throw snapshot.error!;
                    }

                    return const CircularProgressIndicator();
                  }
              ),
              SizedBox(height:20),
            ]
        )
    );
  }
}

//Método provisorio para obtener data hardcodeada de un game
Future<SummonerMatchInfo> getMockedInfo(summonerPiuud) async {
  String matchId = "LA2_1184447522";
  String url = "https://americas.api.riotgames.com/lol/match/v5/matches/${matchId}";
  var res = await http.get(Uri.parse(url), headers: {
    "X-Riot-Token": "RGAPI-e26125cc-38e2-48ea-817a-22ce30e85e22"
  });

  Map<String, dynamic> parsedJson = jsonDecode(res.body);

  return SummonerMatchInfo.fromJson(summonerPiuud, parsedJson);
}