import 'package:flutter/material.dart';
import '../../model/match/match_participant.dart';
import '../../model/match/match.dart';
import '../../model/summoner.dart';
import 'match_participant_row.dart';

class MatchSummary extends StatelessWidget {

  const MatchSummary({Key? key, required this.match,
    required this.matchParticipant,
    required this.summoner,
  }) : super(key: key);

  final Match match;
  final MatchParticipant matchParticipant;
  final Summoner summoner;
  static const Color winnerColor = Color(0xff92DEF6);
  static const Color looserColor = Color(0xffFB9191);
  static const Color playerWinnerColor = Color(0xff456bf8);
  static const Color playerLooserColor = Color(0xffff4040);


  @override
  Widget build(BuildContext context) {
    return Column(
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
      );
  }

  List<MatchParticipant> _orderParticipantsByTeamAndPosition() {
    // TODO: Fix. This fails if it's an ARAM (probably because it doesn't return positions...)
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
