import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test_project/components/MatchPreview.dart';
import '../Summoner.dart';
import '../SummonerMatchInfo.dart';
import '../components/SummonerWidget.dart';

const String API_KEY = "RGAPI-3fb16f8d-7dad-4b2b-a466-1b2915e47fde";
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
  List<SummonerMatchInfo> matchHistory = [];
  late Future<List<SummonerMatchInfo>> matchHistoryInfo;

  _SummonerHistoryState();

  @override
  void initState() {
    super.initState();

    //TODO: CAMBIAR SummonerMatchInfo a Match asi se puede usar en la vista de Match
    setMatchHistory(summonerPuuid);
  }

  void setMatchHistory(summonerPuuid) {
    matchHistory.clear();
    setMatchHistoryFuture(widget.summoner.getSummonerPuuid()!, 0, 5);
    matchHistoryInfo.then((matches) {
      matchHistory = matches;
    });
  }

  void addGamesToMatchHistory(summonerPuuid, limit) {
    setMatchHistoryFuture(widget.summoner.getSummonerPuuid()!, matchHistory.length, limit);
    matchHistoryInfo.then((matches) { 
      matchHistory.addAll(matches); 
    });
  }

  Future refresh() async{
    setState((){
        setMatchHistory(widget.summoner.summonerPuuid);
    });
  }

  void setMatchHistoryFuture(summonerPuuid, start, limit) async {
    print("SET MATCH HISTORY");
    setState(() {
      matchHistoryInfo = fetchMatchHistory(summonerPuuid, start, limit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Color(0xff263F65),
      body: RefreshIndicator(
        onRefresh: () => refresh(),
        child: SingleChildScrollView(
          child:  Column(
            children: <Widget>[
              SummonerWidget(summoner: widget.summoner, refreshMatchHistory: setMatchHistory),
              FutureBuilder<List<SummonerMatchInfo>>(
                future: matchHistoryInfo,
                builder: (BuildContext context, AsyncSnapshot<List<SummonerMatchInfo>> snapshot) {
                  if(snapshot.hasError) {
                    return Text("${snapshot.error}", style: TextStyle(color: Colors.white));
                  } else if(matchHistory.isEmpty && snapshot.connectionState == ConnectionState.done) {
                    return Text("We couldn't find any games on your match history", style: TextStyle(color: Colors.white));
                  } else if(matchHistory.isNotEmpty && snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: <Widget>[
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: matchHistory.length,
                          itemBuilder: (context, index) {
                            return MatchPreview(summonerMatchInfo: matchHistory[index]);
                        }),
                        Container(
                          color: Color(0xffeaeaea),
                          height: 50,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                          child: TextButton(
                            child: Text("Show more", style: TextStyle(fontSize: 22),),
                            onPressed: () { addGamesToMatchHistory(summonerPuuid, 5); },
                          ),
                        ),
                      ],
                    );
                  } else if(matchHistory.isNotEmpty && snapshot.connectionState != ConnectionState.done) {
                    return Column(
                      children: <Widget>[
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: matchHistory.length,
                            itemBuilder: (context, index) {
                              return MatchPreview(summonerMatchInfo: matchHistory[index]);
                            }),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Center(
                              child: CircularProgressIndicator()
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              ),
              SizedBox(height:20),
            ]
          )
        ),
      )
    );
  }

  Future<List<SummonerMatchInfo>> fetchMatchHistory(String summonerPuuid, int start, int count) async {
    var matchIds = await fetchMatchIds(summonerPuuid, start, count);
    List<SummonerMatchInfo> matchHistoryInfo = [];

    for (var matchId in matchIds) {
      SummonerMatchInfo? matchInfo = await fetchSummonerMatchInfo(summonerPuuid, matchId);
      if(matchInfo != null) {
        matchHistoryInfo.add(matchInfo);
      }
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

  Future<SummonerMatchInfo?> fetchSummonerMatchInfo(String summonerPuuid, String matchId) async {
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
}

