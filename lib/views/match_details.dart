import 'package:flutter/material.dart';
import 'package:test_project/components/match_participant_row.dart';
import '../model/match/match_participant.dart';
import '../model/match/match.dart';

class MatchDetails extends StatelessWidget {
  const MatchDetails({Key? key,
    required this.match,
    required this.matchParticipant}) : super(key: key);

  final Match match;
  final MatchParticipant matchParticipant;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff263F65),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: match.participants.length,
                    itemBuilder: (context, index) {
                      var currentParticipant = _orderParticipantsByTeamAndPosition()[index];
                      return MatchParticipantRow(championName: currentParticipant.championName,
                          mainRune: "",
                          secondaryRune: "",
                          summonerName: currentParticipant.summonerName,
                          score: currentParticipant.getScoreAsString(),
                          kda: currentParticipant.getKDA(),
                          items: currentParticipant.build
                      );
                    }),
              ],
            )

          ],
        )
    );
  }

  List<MatchParticipant> _orderParticipantsByTeamAndPosition() {
    List<MatchParticipant> orderedList = [];
    bool playerWin = matchParticipant.win;
    orderedList.add(match.participants.firstWhere((participant) => participant.teamPosition == "TOP" && participant.win == playerWin));
    orderedList.add(match.participants.firstWhere((participant) => participant.teamPosition == "JUNGLE" && participant.win == playerWin));
    orderedList.add(match.participants.firstWhere((participant) => participant.teamPosition == "MIDDLE" && participant.win == playerWin));
    orderedList.add(match.participants.firstWhere((participant) => participant.teamPosition == "BOTTOM" && participant.win == playerWin));
    orderedList.add(match.participants.firstWhere((participant) => participant.teamPosition == "UTILITY" && participant.win == playerWin));
    orderedList.add(match.participants.firstWhere((participant) => participant.teamPosition == "TOP" && participant.win != playerWin));
    orderedList.add(match.participants.firstWhere((participant) => participant.teamPosition == "JUNGLE" && participant.win != playerWin));
    orderedList.add(match.participants.firstWhere((participant) => participant.teamPosition == "MIDDLE" && participant.win != playerWin));
    orderedList.add(match.participants.firstWhere((participant) => participant.teamPosition == "BOTTOM" && participant.win != playerWin));
    orderedList.add(match.participants.firstWhere((participant) => participant.teamPosition == "UTILITY" && participant.win != playerWin));
    return orderedList;
  }

}