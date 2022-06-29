import 'package:flutter/material.dart';
import 'package:test_project/model/live_match/live_match_participant.dart';
import 'package:test_project/model_parsers/live_match_parser.dart';
import 'navigation_drawer.dart';
import 'dart:convert';
import '../model/live_match/live_match.dart';
import '../model/live_match/live_match_participant.dart';
import '../request_resolvers/live_match_request_resolver.dart';
import '../model/live_match/champion_portrait.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../request_resolvers/summoner_request_resolver.dart';
import '../model/summoner/summoner.dart';
import '../views/summoner_history.dart';

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
  late Map <String, dynamic> summonerSpellJson;

  @override
  void initState() {
      super.initState();
      setChampionJson();
      setSummonerSpellJson();
      setLiveMatch(widget.summonerId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xff263F65),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                                  .white));
                        } else if (liveMatch == null && snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200.0,
                                height: 200.0,
                                child: Image.asset('assets/BlitzQuestionMark.png'),
                              ),
                              Text("Live game not found.", style: TextStyle(fontSize: 13.0, color: Colors.white)),
                            ],
                          );
                        } else if (liveMatch == null && snapshot.connectionState != ConnectionState.done) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Center(
                                child: CircularProgressIndicator()
                            ),
                          );
                        } else if ((liveMatch!.participants).length != 10 && snapshot.connectionState != ConnectionState.done) {
                          return Column(
                            children: [
                              SizedBox(
                                width: 200.0,
                                height: 200.0,
                                child: Image.asset('assets/BlitzQuestionMark.png'),
                              ),
                              Text("Invalid game mode.", style: TextStyle(fontSize: 13.0, color: Colors.white)),
                            ],
                          );
                        } else if ((liveMatch!.participants).isEmpty &&
                            snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200.0,
                                height: 200.0,
                                child: Image.asset('assets/BlitzQuestionMark.png'),
                              ),
                              Text("Game participants not found.", style: TextStyle(fontSize: 20.0, color: Colors.white)),
                            ],
                          );
                        } else if ((liveMatch!.participants).isNotEmpty &&
                            snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 14, 2, 13),
                                color: Color(0xff2b4673),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("${liveMatch!.getQueueType()} | ${liveMatch!.getMapName()}",
                                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 35.0,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                    color: Color(0xff1483d9),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Blue team",
                                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Bans: ", style: TextStyle(color:Colors.white, fontSize: 16.0)),
                                            ChampionPortrait(championName: getChampionNameFromId(champDataJson, liveMatch!.bannedChampionsIds[0]), imageSize: 30),
                                            SizedBox(width: 1),
                                            ChampionPortrait(championName: getChampionNameFromId(champDataJson, liveMatch!.bannedChampionsIds[1]), imageSize: 30),
                                            SizedBox(width: 1),
                                            ChampionPortrait(championName: getChampionNameFromId(champDataJson, liveMatch!.bannedChampionsIds[2]), imageSize: 30),
                                            SizedBox(width: 1),
                                            ChampionPortrait(championName: getChampionNameFromId(champDataJson, liveMatch!.bannedChampionsIds[3]), imageSize: 30),
                                            SizedBox(width: 1),
                                            ChampionPortrait(championName: getChampionNameFromId(champDataJson, liveMatch!.bannedChampionsIds[4]), imageSize: 30),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        LiveMatchParticipant currentParticipant = liveMatch!
                                            .participants[index];
                                        return InkWell(
                                          onTap: () async {
                                            Summoner currentSummoner = await fetchSummonerInfo(currentParticipant.summonerName);
                                            currentSummoner.addLeagueInfo(await fetchSummonerLeagueInfo(currentSummoner.summonerId!));

                                            Navigator.push(context,
                                              MaterialPageRoute(
                                                builder: (context) => SummonerHistory(summoner: currentSummoner),
                                              ),
                                            );
                                          },

                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(4, 4, 20, 4),
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                ChampionPortrait(championName: getChampionNameFromId(champDataJson,currentParticipant.championId), imageSize: 40),
                                                SizedBox(width: 2),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                      Image.network(
                                                          'http://ddragon.leagueoflegends.com/cdn/12.12.1/img/spell/${getSummonerSpellNameFromId(summonerSpellJson, currentParticipant.spell1Id)}.png',
                                                          width: 19,
                                                          height: 19,
                                                      ),
                                                      SizedBox(height: 2,),
                                                      Image.network(
                                                        'http://ddragon.leagueoflegends.com/cdn/12.12.1/img/spell/${getSummonerSpellNameFromId(summonerSpellJson, currentParticipant.spell2Id)}.png',
                                                        width: 19,
                                                        height: 19,
                                                      )
                                                  ],
                                                ),
                                                SizedBox(width: 8,),
                                                Text(
                                                  currentParticipant.summonerName,
                                                  style: TextStyle(fontSize: 14.0),
                                                ),
                                                Expanded(child: SizedBox()),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                  Container(
                                    height: 35.0,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                    color: Color(0xffc41e1e),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Red team",
                                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Bans: ", style: TextStyle(color:Colors.white, fontSize: 16.0)),
                                            ChampionPortrait(championName: getChampionNameFromId(champDataJson, liveMatch!.bannedChampionsIds[5]), imageSize: 30),
                                            SizedBox(width: 1),
                                            ChampionPortrait(championName: getChampionNameFromId(champDataJson, liveMatch!.bannedChampionsIds[6]), imageSize: 30),
                                            SizedBox(width: 1),
                                            ChampionPortrait(championName: getChampionNameFromId(champDataJson, liveMatch!.bannedChampionsIds[7]), imageSize: 30),
                                            SizedBox(width: 1),
                                            ChampionPortrait(championName: getChampionNameFromId(champDataJson, liveMatch!.bannedChampionsIds[8]), imageSize: 30),
                                            SizedBox(width: 1),
                                            ChampionPortrait(championName: getChampionNameFromId(champDataJson, liveMatch!.bannedChampionsIds[9]), imageSize: 30),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
                                      itemBuilder: (context, index) {
                                        LiveMatchParticipant currentParticipant = liveMatch!
                                            .participants[index+5];
                                        return InkWell(
                                          onTap: () async {
                                            Summoner currentSummoner = await fetchSummonerInfo(currentParticipant.summonerName);
                                            currentSummoner.addLeagueInfo(await fetchSummonerLeagueInfo(currentSummoner.summonerId!));

                                            Navigator.push(context,
                                              MaterialPageRoute(
                                                builder: (context) => SummonerHistory(summoner: currentSummoner),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(4, 4, 20, 4),
                                            color: Colors.white,
                                            child: Row(
                                              children: [
                                                ChampionPortrait(championName: getChampionNameFromId(champDataJson,currentParticipant.championId), imageSize: 40),
                                                SizedBox(width: 2),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Image.network(
                                                      'http://ddragon.leagueoflegends.com/cdn/12.12.1/img/spell/${getSummonerSpellNameFromId(summonerSpellJson, currentParticipant.spell1Id)}.png',
                                                      width: 19,
                                                      height: 19,
                                                    ),
                                                    SizedBox(height: 2,),
                                                    Image.network(
                                                      'http://ddragon.leagueoflegends.com/cdn/12.12.1/img/spell/${getSummonerSpellNameFromId(summonerSpellJson, currentParticipant.spell2Id)}.png',
                                                      width: 19,
                                                      height: 19,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(width: 8,),
                                                Text(
                                                  currentParticipant.summonerName,
                                                  style: TextStyle(fontSize: 14.0),
                                                ),
                                                Expanded(child: SizedBox()),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ],
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
      liveMatchInfo.then((match) {
          liveMatch = match;
      });
  }

  void setLiveMatchFuture(summonerId) async {
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
  void setSummonerSpellJson() async{
    String spellDataJsonFuture = await rootBundle.loadString('assets/summonerSpell.json');
    Map<String,dynamic> spellData = await jsonDecode(spellDataJsonFuture);

    setState((){
      summonerSpellJson = spellData;
    });
  }
}
