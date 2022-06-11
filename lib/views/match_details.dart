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
  static const Color winnerColor = Color(0xff92DEF6);
  static const Color looserColor = Color(0xffFB9191);
  static const Color playerWinnerColor = Color(0xff456bf8);
  static const Color playerLooserColor = Color(0xffff4040);


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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      var currentParticipant = _orderParticipantsByTeamAndPosition()[index];
                      return MatchParticipantRow(
                          color: _getColor(currentParticipant),
                          championName: currentParticipant.championName,
                          mainRune: "",
                          secondaryRune: "",
                          summonerName: currentParticipant.summonerName,
                          score: currentParticipant.getScoreAsString(),
                          kda: currentParticipant.getKDA(),
                          items: currentParticipant.build
                      );
                    }),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      var currentParticipant = _orderParticipantsByTeamAndPosition()[index+5];
                      return MatchParticipantRow(
                          color: _getColor(currentParticipant),
                          championName: currentParticipant.championName,
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

  Color _getColor(MatchParticipant currentParticipant) {
    var winner = currentParticipant.summonerPuuid == matchParticipant.summonerPuuid ? playerWinnerColor : winnerColor;
    var looser = currentParticipant.summonerPuuid == matchParticipant.summonerPuuid ? playerLooserColor : looserColor;
    return currentParticipant.win ? winner : looser;
  }

}