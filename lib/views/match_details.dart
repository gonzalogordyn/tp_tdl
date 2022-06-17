import 'package:flutter/material.dart';
import '../model/match/match_participant.dart';
import '../model/match/match.dart';
import '../model/summoner.dart';
import 'navigation_drawer.dart';
import '../components/user_header.dart';
import '../components/match_details/match_summary.dart';

class MatchDetails extends StatelessWidget {
  const MatchDetails({Key? key,
    required this.match,
    required this.matchParticipant,
    required this.summoner}) : super(key: key);


  final Match match;
  final MatchParticipant matchParticipant;
  final Summoner summoner;
  static const Color winnerColor = Color(0xff92DEF6);
  static const Color looserColor = Color(0xffFB9191);
  static const Color playerWinnerColor = Color(0xff456bf8);
  static const Color playerLooserColor = Color(0xffff4040);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff263F65),
        drawer: NavigationDrawer(),
        appBar: userHeader(summoner.summonerIconId!, summoner.summonerLevel!),
        body: MatchSummary(matchParticipant: matchParticipant,
            match: match,
            summoner: summoner),
    );
  }
}