import 'package:flutter/material.dart';
import 'package:test_project/model/live_match/live_match_participant.dart';
import 'package:test_project/model_parsers/live_match_parser.dart';
import 'navigation_drawer.dart';
import 'dart:convert';
import '../model/live_match/live_match.dart';
import '../model/live_match/live_match_participant.dart';
import '../request_resolvers/live_match_resolver.dart';
import 'package:flutter/services.dart' show rootBundle;

class LiveGame extends StatefulWidget {
  final summonerId;

  const LiveGame({Key? key,
      required this.summonerId
  }) : super(key: key);

  @override
  State<LiveGame> createState() => _LiveGameState();
}

class _LiveGameState extends State<LiveGame> {
  late Future<LiveMatch> liveMatchInfo;
  LiveMatch? liveMatch;
  late Map <String, dynamic> champDataJson;

  @override
  void initState() {
      super.initState();
      setChampionJson();
      setLiveMatch(widget.summonerId);
  }

  Widget build(BuildContext context) {

    return Scaffold(
        drawer: NavigationDrawer(),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    color: Colors.white70,
                    child: Text("SoloQueue | Summoner's Rift"),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: liveMatchInfo,
                      builder: (BuildContext context, AsyncSnapshot<LiveMatch> snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}", style: TextStyle(
                              color: Colors
                                  .white)); //TODO: poner mensaje de error
                        } else if (liveMatch == null) {
                          return Text("Could not fetch live match.");
                        } else if ((liveMatch!.participants).isEmpty &&
                            snapshot.connectionState == ConnectionState.done) {
                          return Text(
                              "No match participants found.",
                              style: TextStyle(color: Colors.white));
                        } else if ((liveMatch!.participants).isNotEmpty &&
                            snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    LiveMatchParticipant currentParticipant = liveMatch!
                                        .participants[index];
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Image.network(
                                            'http://ddragon.leagueoflegends.com/cdn/12.11.1/img/champion/${getChampionNameFromId(champDataJson,currentParticipant.championId)}.png',
                                            width: 30,
                                            height: 30,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            currentParticipant.summonerName,
                                            style: TextStyle(fontSize: 10.0),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    LiveMatchParticipant currentParticipant = liveMatch!
                                        .participants[index+5];
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Image.network(
                                            'http://ddragon.leagueoflegends.com/cdn/12.11.1/img/champion/${getChampionNameFromId(champDataJson,currentParticipant.championId)}.png',
                                            width: 30,
                                            height: 30,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            currentParticipant.summonerName,
                                            style: TextStyle(fontSize: 10.0),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              ),
                            ],
                          );
                        } else if((liveMatch!.participants).isNotEmpty && snapshot.connectionState != ConnectionState.done) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Center(
                                  child: CircularProgressIndicator()
                              ),
                            );
                        }
                        return Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Center(
                              child: CircularProgressIndicator()
                          ),
                        );
                      }
                    ),
                  ],
                )
            ],
        )
    );
  }

  void setLiveMatch(summonerId){
      setLiveMatchFuture(widget.summonerId);
      print("test1");
      liveMatchInfo.then((match) {
          liveMatch = match;
          print("test");
      });
  }

  void setLiveMatchFuture(summonerId) async {
      print("SET LIVE MATCH");
      setState(() {
          liveMatchInfo = fetchLiveMatch(summonerId);
      });
  }

  void setChampionJson() async{
    String champDataJsonFuture = await rootBundle.loadString('assets/champion.json');
    Map<String,dynamic> champData = await jsonDecode(champDataJsonFuture);

    setState((){
        champDataJson = champData;
    });
  }
}
