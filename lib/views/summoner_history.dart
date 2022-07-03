import 'dart:core';
import 'package:flutter/material.dart';
import 'package:test_project/components/user_header.dart';
import './match_details.dart';
import '../components/match_preview.dart';
import '../views/navigation_drawer.dart';
import '../model/summoner/summoner.dart';
import '../components/summoner_widget.dart';
import '../request_resolvers/match_request_resolver.dart';
import '../model/match/match.dart';
import './summoner_stats.dart';

class SummonerHistory extends StatefulWidget {
  final Summoner summoner;

  SummonerHistory({
    Key? key, required this.summoner
  }) : super(key: key);

  @override
  _SummonerHistoryState createState() => _SummonerHistoryState();

}

class _SummonerHistoryState extends State<SummonerHistory> {
  List<Match> matchHistory = [];
  late Future<List<Match>> matchHistoryInfo;

  _SummonerHistoryState();

  @override
  void initState() {
    super.initState();

    //TODO: CAMBIAR SummonerMatchInfo a Match asi se puede usar en la vista de Match
    setMatchHistory(widget.summoner.summonerPuuid);
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
    setState(() {
      matchHistoryInfo = fetchMatchHistory(summonerPuuid, start, limit, widget.summoner.region);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: userHeader(widget.summoner.summonerIconId!, widget.summoner.summonerLevel!),
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
                    return Text("${snapshot.error}", style: TextStyle(color: Colors.white)); //TODO: poner mensaje de error
                  } else if(matchHistory.isEmpty && snapshot.connectionState == ConnectionState.done) {
                    return Text("We couldn't find any games on your match history", style: TextStyle(color: Colors.white));
                  } else if(matchHistory.isNotEmpty && snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: <Widget>[
                        TextButton(
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                color: Color(0xffeaeaea),
                                border: Border.all(
                                  color: Color(0xff333333),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text("Show statistics", style: TextStyle(fontSize: 22)),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Color(0xff05aefc),
                                    size: 30,
                                  ),
                                ]
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SummonerStats(
                                  summoner: widget.summoner,
                                  matchHistory: matchHistory,
                                ),
                              ),
                            );
                          },
                        ),
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
                                      matchParticipant: matchHistory[index].getParticipantWithSummonerPuuid(widget.summoner.getSummonerPuuid()!),
                                      summoner: widget.summoner
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
                            onPressed: () { addGamesToMatchHistory(widget.summoner.summonerPuuid, 5); },
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
