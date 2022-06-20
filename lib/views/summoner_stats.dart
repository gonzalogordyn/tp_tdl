import 'dart:core';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/components/user_header.dart';
import 'package:test_project/model/match/match_participant.dart';
import '../model/summoner/league.dart';
import './match_details.dart';
import '../components/match_preview.dart';
import '../views/navigation_drawer.dart';
import '../model/summoner/summoner.dart';
import '../components/summoner_widget.dart';
import '../request_resolvers/match_request_resolver.dart';
import '../model/match/match.dart';

//TODO: pasar a otra clase
TextStyle defaultTextStyle = TextStyle(
    color: Color(0xff6b6b6b),
    fontFamily: GoogleFonts.inter().fontFamily,
    fontSize: 16
);

EdgeInsets sectionPadding = EdgeInsets.fromLTRB(15, 15, 15, 5);

class SummonerStats extends StatelessWidget {
  final Summoner summoner;
  final List<Match> matchHistory;

  SummonerStats({
    Key? key,
    required this.summoner,
    required this.matchHistory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: userHeader(summoner.summonerIconId!, summoner.summonerLevel!),
      backgroundColor: Color(0xff263F65),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(summoner.summonerName!,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32
                      )
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffeaeaea),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(
                  children: [
                    _SummonerDivision(summoner: summoner, matchHistory: matchHistory),
                    Divider(color: Color(0xffBCBCBC), thickness: 1),
                    _LastMatchesWinrate(summoner: summoner, matchHistory: matchHistory),
                    Divider(color: Color(0xffBCBCBC), thickness: 1),
                    _MostPlayedChampions(summoner: summoner, matchHistory: matchHistory),
                    Divider(color: Color(0xffBCBCBC), thickness: 1),
                    _RecentlyPlayedWith(summoner: summoner, matchHistory: matchHistory),
                  ],
                ),
              )
            ],
          )
        ),
    )
    );
  }
}

class _SummonerDivision extends StatelessWidget {
  final Summoner summoner;
  final List<Match> matchHistory;

  _SummonerDivision({
    Key? key,
    required this.summoner,
    required this.matchHistory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    League? league = summoner.getSummonerMainLeague();
    if(league == null) {
      return Container(); //Returns empty widget
    }

    return Container(
      padding: sectionPadding,
      child: Column(children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          alignment: Alignment.centerLeft,
          child: Text("${league.queueType}",
            style: defaultTextStyle
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 15, 0),
              child: Image.asset("assets/ranked_emblems/Emblem_${league.tier}.png",
                width: 56,
                height: 63,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text("${league.tier} ${league.rank}", style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  )),
                ),
                Text("${league.lp} LP", style: defaultTextStyle),
              ]
            ),
            Container(
              margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text("${league.wins}W ${league.losses}L", style: defaultTextStyle),
                    ),
                    Text("Winrate ${league.getWinrate().toStringAsFixed(0)}%", style: defaultTextStyle),
                  ]
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class _LastMatchesWinrate extends StatelessWidget {
  final Summoner summoner;
  final List<Match> matchHistory;

  _LastMatchesWinrate({
    Key? key,
    required this.summoner,
    required this.matchHistory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> avgScore = getAverageScore(summoner.summonerPuuid!, matchHistory);
    double averageKDA = 0;
    if(avgScore["deaths"]! > 0) {
      averageKDA = (avgScore["kills"]! + avgScore["assists"]!) / avgScore["deaths"]!;
    }

    return Container(
      padding: sectionPadding,
      child: Column(children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          alignment: Alignment.centerLeft,
          child: Text("${matchHistory.length}G "
              "${getWins(summoner.summonerName!, matchHistory).length}W "
              "${getLosses(summoner.summonerName!, matchHistory).length}L",
            style: defaultTextStyle,
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  PieChart(
                    PieChartData(
                      startDegreeOffset: 270,
                      sectionsSpace: 0,
                      centerSpaceRadius: 30,
                      sections: [
                        PieChartSectionData(
                          color: Color(0xFFEE5A52),
                          value: getLosses(summoner.summonerName!, matchHistory).length.toDouble(),
                          radius: 17,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          color: Color(0xFF1F8ECD),
                          value: getWins(summoner.summonerName!, matchHistory).length.toDouble(),
                          radius: 17,
                          showTitle: false,
                        ),
                      ]
                    )
                  ),
                  Text("${getWinrate(summoner.summonerName!, matchHistory).toStringAsFixed(0)}%",
                    style: defaultTextStyle,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text("${avgScore["kills"]!.toStringAsFixed(1)} / ${avgScore["deaths"]!.toStringAsFixed(1)} / ${avgScore["assists"]!.toStringAsFixed(1)}",
                      style: defaultTextStyle,
                    ),
                  ),
                  Text("${averageKDA.toStringAsFixed(2)} KDA",
                    style: defaultTextStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}

class _MostPlayedChampions extends StatelessWidget {
  final Summoner summoner;
  final List<Match> matchHistory;

  _MostPlayedChampions({
    Key? key,
    required this.summoner,
    required this.matchHistory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> mostPlayedChamps = getMostPlayedChampionsData(summoner.summonerPuuid!, matchHistory);
    print("MOST PLAYED CHAMPS:");
    print("${mostPlayedChamps.length}");
    /*
    padding: EdgeInsets.symmetric(horizontal: 15),*/
    return Container(
      padding: sectionPadding,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 15),
            child: Text("Recently played champions", style: defaultTextStyle),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: mostPlayedChamps.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 13),
                      child: CircleAvatar(
                          backgroundColor: Color(0xff000000),
                          radius: 23,
                          child: CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage("http://ddragon.leagueoflegends.com/cdn/12.11.1/img/champion/${mostPlayedChamps[index]["name"]}.png"),
                          )
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 3),
                          child: Text("${mostPlayedChamps[index]["name"]}", style: defaultTextStyle),
                        ),
                        Text("${calculateWinrate(mostPlayedChamps[index]["wins"], mostPlayedChamps[index]["losses"]).toStringAsFixed(0)}% "
                            "(${mostPlayedChamps[index]["wins"]}W ${mostPlayedChamps[index]["losses"]}L)",
                          style: defaultTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 9, left: 18),
                          child: Text("${calculateKDA(mostPlayedChamps[index]["kills"],
                              mostPlayedChamps[index]["deaths"],
                              mostPlayedChamps[index]["assists"]).toStringAsFixed(2)} KDA",
                            style: defaultTextStyle,
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}

class _RecentlyPlayedWith extends StatelessWidget {
  final Summoner summoner;
  final List<Match> matchHistory;

  _RecentlyPlayedWith({
    Key? key,
    required this.summoner,
    required this.matchHistory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> mostPlayedWith = getMostPlayedWithSummoners(summoner, matchHistory);
    List mostPlayedWithData = mostPlayedWith.map((friendSummonerName) => getFriendData(friendSummonerName, matchHistory)).toList();

    print("MOST PLAYED WITH: ");
    print(mostPlayedWith.length);

    if(mostPlayedWith.isEmpty) {
      return Container();
    }

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            alignment: Alignment.centerLeft,
            child: Text("Recently played with", style: defaultTextStyle),
          ),
          DataTable(
            columnSpacing: 25,
            columns: [
              DataColumn(
                  label: Text("Summoner", style: defaultTextStyle)
              ),
              DataColumn(
                  label: Text("Played", style: defaultTextStyle)
              ),
              DataColumn(
                  label: Text("Win", style: defaultTextStyle)
              ),
              DataColumn(
                  label: Text("Lose", style: defaultTextStyle)
              ),
              DataColumn(
                  label: Text("Ratio", style: defaultTextStyle)
              )
            ],
            rows: mostPlayedWithData.map((friendData) => DataRow(
              color: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    // All rows will have the same selected color.
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                    }
                    // Even rows will have a grey color.
                    if (mostPlayedWithData.indexOf(friendData).isEven) {
                      return Colors.grey.withOpacity(0.3);
                    }
                    return null; // Use default value for other states and odd rows.
                  }),
              cells: _buildDataCells(friendData),
            )).toList(),
          )
        ],
      ),
    );
  }

  List<DataCell> _buildDataCells(Map<String, dynamic> friendData) {
    double winrate = calculateWinrate(friendData["wins"], friendData["losses"]);
    print("WINRATE: $winrate");
    return [
      DataCell(Text("${friendData["summonerName"]}",
        style: defaultTextStyle.copyWith(
          color: Color(0xff000000),
        ))
      ),
      DataCell(Text("${friendData["played"]}", style: defaultTextStyle)),
      DataCell(Text("${friendData["wins"]}", style: defaultTextStyle)),
      DataCell(Text("${friendData["losses"]}", style: defaultTextStyle)),
      DataCell(Text("${winrate.toStringAsFixed(0)}%", style: defaultTextStyle)),
    ];
  }
}

List<Match> getWins(String summonerName, List<Match> matches) {
  return matches.where((match) {
    MatchParticipant? participant = match.getParticipantWithSummonerName(summonerName);
    if(participant != null && participant.win) {
      return true;
    }
    return false;
  }).toList();
}

List<Match> getLosses(String summonerName, List<Match> matches) {
  return matches.where((match) {
    MatchParticipant? participant = match.getParticipantWithSummonerName(summonerName);
    if(participant != null && !participant.win) {
      return true;
    }
    return false;
  }).toList();
}

double calculateKDA(int kills, int deaths, int assists) {
  if(assists == 0) {
    return 0;
  }

  return (kills + assists) / deaths;
}
double calculateWinrate(int wins, int losses) {
  return (wins / (wins + losses)) * 100;
}

double getWinrate(String summonerName, List<Match> matches) {
  int wins = getWins(summonerName, matches).length;
  int losses = getLosses(summonerName, matches).length;

  if(losses == 0) {
    return 100;
  }

  return calculateWinrate(wins, losses);
}

Map<String, double> getAverageScore(String summonerPuuid, List<Match> matches) {
  int sumKills = 0;
  int sumDeaths = 0;
  int sumAssists = 0;
  int amountOfMatches = matches.length;

  for(Match match in matches) {
    MatchParticipant summonerInfo = match.getParticipantWithSummonerPuuid(summonerPuuid);
    sumKills += summonerInfo.kills;
    sumDeaths += summonerInfo.deaths;
    sumAssists += summonerInfo.assists;
  }

  return {
    "kills": sumKills / amountOfMatches,
    "deaths": sumDeaths / amountOfMatches,
    "assists": sumAssists / amountOfMatches,
  };
}

List<dynamic> getMostPlayedChampionsData(String summonerPuuid, List<Match> matchHistory) {
  List<dynamic> championsPlayed = [];

  for(Match match in matchHistory) {
    MatchParticipant summonerInfo = match.getParticipantWithSummonerPuuid(summonerPuuid);
    String champPlayed = summonerInfo.championName;

    int championListIndex = championsPlayed.indexWhere((champion) => champion["name"] == champPlayed);
    if(championListIndex < 0) {
      championsPlayed.add({
        "name": summonerInfo.championName,
        "amountOfMatches": 1,
        "kills": summonerInfo.kills,
        "deaths": summonerInfo.deaths,
        "assists": summonerInfo.assists,
        "wins": summonerInfo.win == true ? 1 : 0,
        "losses": summonerInfo.win == false ? 1 : 0,
      });
    }
    else {
      championsPlayed[championListIndex]["amountOfMatches"]++;
      championsPlayed[championListIndex]["kills"] += summonerInfo.kills;
      championsPlayed[championListIndex]["deaths"] += summonerInfo.deaths;
      championsPlayed[championListIndex]["assists"] += summonerInfo.assists;
      if(summonerInfo.win) {
        championsPlayed[championListIndex]["wins"]++;
      }
      else {
        championsPlayed[championListIndex]["losses"]++;
      }
    }
  }

  championsPlayed.sort((c2, c1) => (c1["amountOfMatches"] as int).compareTo(c2["amountOfMatches"]));

  return championsPlayed.take(3).toList();
}

List<String> getMostPlayedWithSummoners(Summoner summoner, List<Match> matchHistory) {
  List<Map<String, dynamic>> mostPlayedWith = [];

  for(Match match in matchHistory) {
    for(MatchParticipant participant in match.participants) {
      if(participant.summonerName == summoner.summonerName) {
        continue;
      }

      int participantIndex = mostPlayedWith.indexWhere((mostPlayedWithSummoner) => mostPlayedWithSummoner["summonerName"] == participant.summonerName);
      if(participantIndex < 0) {
        mostPlayedWith.add({
          "summonerName": participant.summonerName,
          "amountOfMatches": 1
        });
      } else {
        mostPlayedWith[participantIndex]["amountOfMatches"]++;
      }
    }
  }

  mostPlayedWith.sort((s2, s1) {
    return (s1["amountOfMatches"] as int).compareTo((s2["amountOfMatches"] as int));
  });
  //for (var player in mostPlayedWith) {print("${player["summonerName"]}: ${player["amountOfMatches"]}");}
  List<Map<String, dynamic>> top10 = mostPlayedWith.take(10).toList();
  top10 = top10.where((friend) => friend["amountOfMatches"] > 1).toList(); //Removes players with just 1 game
  List<String> mostPlayedWithSummonerNames = top10.map((listEntry) => (listEntry["summonerName"] as String) ).toList(); //

  return mostPlayedWithSummonerNames;
}

Map<String, dynamic> getFriendData(String friendSummonerName, List<Match> matchHistory) {
  List<Match> matchesPlayed;
  int wins;
  int losses;

  //TODO: obtener solo los games donde esta en el equipo del jugador y no en el equipo contrario (falta recibir summonerName)
  matchesPlayed = matchHistory.where((match) => (match.getParticipantWithSummonerName(friendSummonerName) != null)).toList();

  return {
    "summonerName": friendSummonerName,
    "played": matchesPlayed.length,
    "wins": getWins(friendSummonerName, matchesPlayed).length,
    "losses": getLosses(friendSummonerName, matchesPlayed).length
  };
}