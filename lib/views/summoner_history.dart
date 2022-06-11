import 'dart:core';
import 'package:flutter/material.dart';
import './match_details.dart';
import '../components/match_preview.dart';
import '../views/navigation_drawer.dart';
import '../model/summoner.dart';
import '../components/summoner_widget.dart';
import '../request_resolvers/match_request_resolver.dart';
import '../model/match/match.dart';

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
  List<Match> matchHistory = [];
  late Future<List<Match>> matchHistoryInfo;

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
      drawer: NavigationDrawer(),
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Color(0xff263F65),
        centerTitle: true,
        title: Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Stack(
                children: [
                    CircleAvatar(
                        backgroundColor: Color(0xffa98101),
                        radius: 20,
                        child: CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage("http://ddragon.leagueoflegends.com/cdn/12.11.1/img/profileicon/${widget.summoner.summonerIconId}.png"),
                        )
                    ),
                    Positioned(
                      top: 28.0,
                      left: 5.0,
                      child: Container(
                          width: 30,
                          height: 15,
                          color: Color(0xffa98101),
                          child: Text("${widget.summoner.summonerLevel!}",
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                          ),
                      ),
                    ),
                  ],
            )
        ),
      ),
      backgroundColor: Color(0xff263F65),
      body: RefreshIndicator(
        onRefresh: () => refresh(),
        child: SingleChildScrollView(
          child:  Column(
            children: <Widget>[
              SummonerWidget(summoner: widget.summoner, refreshMatchHistory: setMatchHistory),
              FutureBuilder<List<Match>>(
                future: matchHistoryInfo,
                builder: (BuildContext context, AsyncSnapshot<List<Match>> snapshot) {
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
                            return InkWell(
                                onTap: () { Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MatchDetails(match: matchHistory[index],
                                      matchParticipant: matchHistory[index].getParticipantWithSummonerPuuid(widget.summoner.getSummonerPuuid()!)
                                      ,),
                                  ),
                                );},
                                child: MatchPreview(
                                    matchParticipant: matchHistory[index].getParticipantWithSummonerPuuid(widget.summoner.getSummonerPuuid()!),
                                    match: matchHistory[index])
                            );
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
                              return MatchPreview(
                                  matchParticipant: matchHistory[index].getParticipantWithSummonerPuuid(widget.summoner.getSummonerPuuid()!),
                                  match: matchHistory[index]
                              );
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
}
