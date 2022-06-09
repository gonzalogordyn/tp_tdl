import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test_project/components/MatchPreview.dart';
import '../Summoner.dart';
import '../SummonerMatchInfo.dart';

const String API_KEY = "RGAPI-bcdb9e9a-4f3f-4013-a513-ff9b7908dd8e";
const String summonerPuuid = "hpjXwNk0c78BWy4uiS9ZMYsKVxPdFSw1peyhtAW9ei6Mdwl7F8S3D7rVguMFcOCHtoFsjvl2FXdxpg";

class SummonerHistory extends StatefulWidget {
  final Summoner summoner;

  SummonerHistory({
    Key? key, required this.summoner
  }) : super(key: key);

  @override
  _SummonerHistoryState createState() => _SummonerHistoryState();

}

class _SummonerHistoryState extends State<SummonerHistory> {

  final String summonerPuuid = "Jm1edPNuEnyrMqbf0fEhzHIP6o5KHqUcBxJl8tC7ZGUdEfY1nli8ViVsBp_7mSkp7alrSQ47Y-lwqQ";
  late Future<List<SummonerMatchInfo>> matchHistoryInfo;

  _SummonerHistoryState();

  @override
  void initState() {
    super.initState();

    //TODO: CAMBIAR SummonerMatchInfo a Match asi se puede usar en la vista de Match
    matchHistoryInfo = fetchMatchHistory(widget.summoner.getSummonerPuuid()!, 0, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff263F65),
        child: SingleChildScrollView(
          child:  Column(
            children: <Widget>[
              SizedBox(height:60),
              Text("SUMMONER_NAME", style: TextStyle(color: Colors.white),),
              SizedBox(height:50),
              FutureBuilder<List<SummonerMatchInfo>>(
                future: matchHistoryInfo,
                builder: (BuildContext context, AsyncSnapshot<List<SummonerMatchInfo>> snapshot) {
                  if(snapshot.hasError) {
                    return Text("${snapshot.error}", style: TextStyle(color: Colors.white));
                  } else if(!snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                    return Text("We couldn't find any games on your match history", style: TextStyle(color: Colors.white));
                  } else if(snapshot.hasData) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return MatchPreview(summonerMatchInfo: snapshot.data![index]);
                    });
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              ),

              SizedBox(height:20),
            ]
        )
    );
  }
}

Future<List<SummonerMatchInfo>> fetchMatchHistory(String summonerPuuid, int start, int count) async {
  var matchIds = await fetchMatchIds(summonerPuuid, start, count);
  List<SummonerMatchInfo> matchHistoryInfo = [];

  for (var matchId in matchIds) {
    SummonerMatchInfo matchInfo = await fetchSummonerMatchInfo(summonerPuuid, matchId);
    matchHistoryInfo.add(matchInfo);
  }

  return matchHistoryInfo;
}

Future<List<dynamic>> fetchMatchIds(String summonerPuuid, int start, int count) async {
  String base = "americas.api.riotgames.com";
  String endpoint = "/lol/match/v5/matches/by-puuid/${summonerPuuid}/ids";
  final params = {
    'start': start.toString(),
    'count': count.toString()
  };
  var matchIdsResult = await http.get(Uri.https(base, endpoint, params), headers: {
    "X-Riot-Token": API_KEY
  });
  await Future.delayed(Duration(seconds: 1));

  return jsonDecode(matchIdsResult.body);
}

Future<SummonerMatchInfo> fetchSummonerMatchInfo(String summonerPuuid, String matchId) async {
  String url = "https://americas.api.riotgames.com/lol/match/v5/matches/${matchId}";
  var res = await http.get(Uri.parse(url), headers: {
    "X-Riot-Token": API_KEY
  });

  Map<String, dynamic> parsedJson = jsonDecode(res.body);
  if (res.statusCode == 200) {
    return SummonerMatchInfo.fromJson(summonerPuuid, parsedJson);
  } else {
    throw Exception('An error occurred fetching the match data with id $matchId. Please try again later. ${res.body}');
  }
}
