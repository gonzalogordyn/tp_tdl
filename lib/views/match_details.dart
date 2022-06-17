import 'package:flutter/material.dart';
import '../model/match/match_participant.dart';
import '../model/match/match.dart';
import '../model/summoner.dart';
import 'navigation_drawer.dart';
import '../components/user_header.dart';
import '../components/match_details/match_summary.dart';

class MatchDetails extends StatefulWidget {
  final Match match;
  final MatchParticipant matchParticipant;
  final Summoner summoner;

  const MatchDetails({Key? key,
    required this.match,
    required this.matchParticipant,
    required this.summoner}) : super(key: key);

  @override
  _MatchDetails createState() => _MatchDetails();
}

class _MatchDetails extends State<MatchDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff263F65),
        drawer: NavigationDrawer(),
        appBar: userHeader(widget.summoner.summonerIconId!, widget.summoner.summonerLevel!),
        body: MatchSummary(matchParticipant: widget.matchParticipant,
            match: widget.match,
            summoner: widget.summoner),
    );
  }
}